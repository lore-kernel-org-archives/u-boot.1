Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB137C072A2
	for <u-boot@archiver.kernel.org>; Wed, 22 Nov 2023 04:16:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AFE45875AA;
	Wed, 22 Nov 2023 05:16:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="d0Sct2uY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF582875CA; Wed, 22 Nov 2023 05:16:23 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B600780EEB
 for <u-boot@lists.denx.de>; Wed, 22 Nov 2023 05:16:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1700626561; x=1701231361; i=xypron.glpk@gmx.de;
 bh=RSP6ihIYq791LpWl/B7dnlLo9j0o6//DoZbOPcU2wW8=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=d0Sct2uYuZ0SMxnlF9sT9rkpVguw2exjb3XKqJs+B8gKTe2H9wROrgdB9dmAuwqE
 CChLQvUEVCOwoRxdM8g+U2zxSuusiZEET21jZ4BfL8iG15N/xRm9DDmdysZGLbFCT
 +i279BBfl11RG6WkJd+GD/HlkuKrKmeGmf4rES6yl82KCNxQHMqLLP9ya4TYCUndw
 Cr3g/tWWXwF1e0L3es7vy7UY9rHP3ZHepLOgW06UEtygHZ3KcNtVF8XSeY9Kd5dw4
 bbR3T2ckLnR5cIh5YpgvdoBnhavpeo3mPdHjsgaZwF2YIfFjjS5673eqHJ3ZUfN0J
 Hn5hyEiA4HtxCkEN8g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.94] ([178.202.40.247]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MZkpR-1qrl7H3YGd-00Wlm3; Wed, 22
 Nov 2023 05:16:00 +0100
Message-ID: <e824f58c-499c-4f2f-9742-9e28f1e8bfc7@gmx.de>
Date: Wed, 22 Nov 2023 05:15:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/5] lib: membuff: fix readline not returning line in
 case of overflow
Content-Language: en-US, de-DE
To: Simon Glass <sjg@chromium.org>, Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Lukasz Majewski <lukma@denx.de>, Marek Vasut <marex@denx.de>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, Bin Meng <bmeng@tinylab.org>,
 Ion Agorria <ion@agorria.com>, Harald Seiler <hws@denx.de>,
 Sean Anderson <sean.anderson@seco.com>, Heiko Schocher <hs@denx.de>,
 Dmitrii Merkurev <dimorinny@google.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>, u-boot@lists.denx.de
References: <20231121183510.6451-1-clamor95@gmail.com>
 <20231121183510.6451-5-clamor95@gmail.com>
 <CAPnjgZ14yKRz06=j5+_e7XE2G82PWRb2QijkYsCPXkpqSFtbaQ@mail.gmail.com>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <CAPnjgZ14yKRz06=j5+_e7XE2G82PWRb2QijkYsCPXkpqSFtbaQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:qTWuA7U+h32ONJZjEnzBWWJb7FEVU1jcvCzvNCGcWGWczbblHVl
 IgDR5iZ74MPAJ5Qy/9PzgO1GH3Rsl75EgkAtA0Sc+SnjQT3257JlK/w7Fge1R9vZujyE+iG
 vvUFzX9Q88ZfPLNHgbbtR3Ji9HBa1C/3Az4hUeISIdWdBcAOEWHbXJJRWPStEi1FGMgRkvm
 rjk6hScjDxDUNMDKzroCA==
UI-OutboundReport: notjunk:1;M01:P0:uLde2I6M6tc=;SRE1ToUtjFcnKbkdjcs0Qv4JbbI
 8X14aHFcLms6jKEwz1or/9TkJ3w/MMwb2aNZq7U0RoqiaEl9mvgX6LHW58MRrs9crzsetLeNC
 M+dk020yK+mjUc5hWt7n5v3uiPyXIY//SkEom/MqG7zk0IVwoOKEyOiBofqaGM2kpemoyYiId
 2qBVaVp7qiZY3rverYaZSAreWO0pvitii/AXuZ7JlmwR62Up/e8y5zTjYbneOLAdcybGSJ4ae
 zJpU7A0LNXXMJj/sxHoZTmO6B0L1bBgChg6guhAK0ay43ntJ1SQJqFIUat08CTnMbfzpGE0ku
 /wslk1oyFw+RHHhraNOkTRsdicwobhxI26SjTHQMCqo4AKvnxipZ2a7QTBkQE9Ky5dKGnLODf
 4/hkBNyWLYislTnCma8NPUWIncUntkPLp2xQ1s5N+OdHke11MXUTSBou/9AFKoYPbRUdmjhvV
 3w8khtRJZfbuLHclWWEnKwVFWGgcqCzs838uXVQdqVkMekxPnsmadmIgBRYgGV46p3ZVd/S4B
 DqB2u1QFBXKdX/fE/ZGtb2z7oBVO5/GOtTbXuhPeYZlJGpdzpPcPsZdtjz8IwDu3DdS81nnVC
 6QbcNdaCycT/3OS2PW+Hvx3R4up6LcP3AgK2Jxg7KbOhu3ZBXIzda87LwZdAENWhit0Bs1mHW
 vAWPCoAK0GqENg8tj7foqEG0EcRnqL6Xog3yY5L3WTT8CQzIRIFreaKE7Ly6r6B7HLlZUPnfV
 QXh+IGaDx6MlipvjFx0T8/P0Ni+BhjxO9Hj6QQh6SzQRlMrt4c0N9OnKlvNBsybyJzQ0geD6z
 q5MvVf4N1z5TD9PlAbyZaeNEG9JkcBzabLFxKsjW1RY2mGWDf52NuhXQxV5+tzuNLoYeVmqmr
 DECsMjxA801D7+MB9kiOu0tIADHU0hXyAZoNy/MKCj/Ic8yPJH7vdhKFgl7OXhGAkZ04BbBEy
 8TlcV3YNwcxV8lUYOSZ9Av6AyZg=
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 11/21/23 19:40, Simon Glass wrote:
> Hi Svyatoslav,
>
> On Tue, 21 Nov 2023 at 11:35, Svyatoslav Ryhel <clamor95@gmail.com> wrot=
e:
>>
>> From: Ion Agorria <ion@agorria.com>
>>
>> If line overflows readline it will not be returned, fix this behavior,
>> make it optional and documented properly.
>>
>> Signed-off-by: Ion Agorria <ion@agorria.com>
>> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
>> Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
>> ---
>>   boot/bootmeth_extlinux.c | 2 +-
>>   common/console.c         | 2 +-
>>   include/membuff.h        | 5 +++--
>>   lib/membuff.c            | 4 ++--
>>   4 files changed, 7 insertions(+), 6 deletions(-)
>>
>> diff --git a/boot/bootmeth_extlinux.c b/boot/bootmeth_extlinux.c
>> index aa2a4591eb..ae0ad1d53e 100644
>> --- a/boot/bootmeth_extlinux.c
>> +++ b/boot/bootmeth_extlinux.c
>> @@ -82,7 +82,7 @@ static int extlinux_fill_info(struct bootflow *bflow)
>>          log_debug("parsing bflow file size %x\n", bflow->size);
>>          membuff_init(&mb, bflow->buf, bflow->size);
>>          membuff_putraw(&mb, bflow->size, true, &data);
>> -       while (len =3D membuff_readline(&mb, line, sizeof(line) - 1, ' =
'), len) {
>> +       while (len =3D membuff_readline(&mb, line, sizeof(line) - 1, ' =
', true), len) {
>>                  char *tok, *p =3D line;
>>
>>                  tok =3D strsep(&p, " ");
>> diff --git a/common/console.c b/common/console.c
>> index 8a869b137e..cd56035171 100644
>> --- a/common/console.c
>> +++ b/common/console.c
>> @@ -846,7 +846,7 @@ bool console_record_overflow(void)
>>   int console_record_readline(char *str, int maxlen)
>>   {
>>          return membuff_readline((struct membuff *)&gd->console_out, st=
r,
>> -                               maxlen, '\0');
>> +                               maxlen, '\0', false);
>>   }
>>
>>   int console_record_avail(void)
>> diff --git a/include/membuff.h b/include/membuff.h
>> index 21051b0c54..4eba626ce1 100644
>> --- a/include/membuff.h
>> +++ b/include/membuff.h
>> @@ -192,10 +192,11 @@ int membuff_free(struct membuff *mb);
>>    * @mb: membuff to adjust
>>    * @str: Place to put the line
>>    * @maxlen: Maximum line length (excluding terminator)
>> + * @must_fit: If true then str is empty if line doesn't fit
>>    * Return: number of bytes read (including terminator) if a line has =
been
>> - *        read, 0 if nothing was there
>> + *        read, 0 if nothing was there or line didn't fit when must_fi=
t is set
>>    */
>> -int membuff_readline(struct membuff *mb, char *str, int maxlen, int mi=
nch);
>> +int membuff_readline(struct membuff *mb, char *str, int maxlen, int mi=
nch, bool must_fit);
>>
>>   /**
>>    * membuff_extend_by() - expand a membuff
>> diff --git a/lib/membuff.c b/lib/membuff.c
>> index 36dc43a523..964e504d5b 100644
>> --- a/lib/membuff.c
>> +++ b/lib/membuff.c
>> @@ -288,7 +288,7 @@ int membuff_free(struct membuff *mb)
>>                          (mb->end - mb->start) - 1 - membuff_avail(mb);
>>   }
>>
>> -int membuff_readline(struct membuff *mb, char *str, int maxlen, int mi=
nch)
>> +int membuff_readline(struct membuff *mb, char *str, int maxlen, int mi=
nch, bool must_fit)
>
> Shouldn't that be the normal case? I might have this wrong, but this
> looks like a bug fix to me.

For the extlinux.conf case assuming that the file has ended if a line is
truncated seems to be the wrong thing to do.

Currently we return a value <=3D maxlen - 1 if no truncation has occurred
and 0 if a truncation occurred.

I would prefer if the function would return maxlen in the case of
truncation and the truncated string. This will allow us to detect
truncation without mistaking it for the end of the buffer.

Best regards

Heinrich

>>   {
>>          int len;  /* number of bytes read (!=3D string length) */
>>          char *s, *end;
>> @@ -310,7 +310,7 @@ int membuff_readline(struct membuff *mb, char *str,=
 int maxlen, int minch)
>>          }
>>
>>          /* couldn't get the whole string */
>> -       if (!ok) {
>> +       if (!ok && must_fit) {
>>                  if (maxlen)
>>                          *orig =3D '\0';
>>                  return 0;
>> --
>> 2.40.1
>>

