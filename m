Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF4DBD74945
	for <u-boot@archiver.kernel.org>; Tue, 29 Oct 2024 22:13:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B0CD89198;
	Tue, 29 Oct 2024 23:13:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="E3emwl1H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 473A78919B; Tue, 29 Oct 2024 23:13:19 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5DAD28918E
 for <u-boot@lists.denx.de>; Tue, 29 Oct 2024 23:13:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1730239991; x=1730844791; i=xypron.glpk@gmx.de;
 bh=nI58uvLtMSFWCSo0/yu2zRexgIHircKu9qMmXXyLYk0=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=E3emwl1HjhQbdzumbCDWJovPK5cNKKPZ4SBIKHQDWmB25EjM6N0ezkKnurMFAyhF
 o1uXt7iqTd94mKlhw2CgaMqBYb2grWQ0sQNjVNuXRuCse4Xqp5H/kvj3RGn7oNnpM
 2PGMzNvE1L4+Ur+9rBMPHpGEc/EaOEtfQ0C0VuRHeIDR7LZx1/VoF8i5DzlY1SA80
 +/dXxn8Tm1u/pKChFR611n49Pai4gVAT69xWLsvpbKbAnyJNPbcN+Zm/o9wJLXEJs
 FSA9baxNTrHmUqFxJPN7xzJvobgRCeUdhQQDq+jPXEXns6AwEl1R1suNa9MlQFala
 eUxdfcApEl+wxTzQ2Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([176.5.140.182]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MGQjH-1t4XP80FX3-009IdV; Tue, 29
 Oct 2024 23:13:11 +0100
Date: Tue, 29 Oct 2024 23:13:08 +0100
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
CC: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_09/15=5D_efi=5Floader=3A_Fix_fr?=
 =?US-ASCII?Q?ee_in_=2E=2E=2E=5Fmedia=5Fdevice=5Fboot=5Foption=28=29?=
User-Agent: K-9 Mail for Android
In-Reply-To: <CAFLszTgG423MQ0iK-2XnOHZN+qVy_-xZNkaPGGsQM=Th=kaeGA@mail.gmail.com>
References: <20241028124815.47262-1-sjg@chromium.org>
 <20241028124815.47262-10-sjg@chromium.org>
 <CAC_iWj+H_m3jiQ-Q-BK=9vtdMEnw0GHyQT2_LFHUYyEnnZh3EQ@mail.gmail.com>
 <CAFLszTgG423MQ0iK-2XnOHZN+qVy_-xZNkaPGGsQM=Th=kaeGA@mail.gmail.com>
Message-ID: <B86C7011-6650-4F3D-9078-67150BADFDEA@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:IJ2ziAQJF+ytWpgQBoea2lleTAPeYPkIEQzNKoEAUzjOQzbpIcf
 hn8pGvVIP7iUQL/XRdvb8nNx3Ye8Kn7jqWHl5CQlov7DbNhNbXYjc1lgMuKO0jXDRZEBBHd
 JuNhmRrwJrS7UZeLrldVxZQDoSfrlIZVxCLpHugVnz1vtl+Mp0O1/FPbfV04KqLAOkUDh+i
 bzmoN7Poyk19pTx4G3HBQ==
UI-OutboundReport: notjunk:1;M01:P0:RiFnAoddhqA=;AecxZeUMkP/ayUChuPMmcZrjFr+
 fWHJClwWTQgRP0/FxRRkst9Xos1MOnh9xyfMPfKBp4h13p0ffgnmmILQAavr71QSNHRfh9VyN
 0SQAiUO7/s54eelTOffgWjq/Tep0pAx+KI8hMvY7w6NXWym1bCNjhajJncv8kueO53UO8kfgl
 Dx5lZdr9QcFe+LewI3/be5nxTSxKNMZcAmYiKMrKp53dKU/pp9fOZj1HEXyB2LtUcrHnb5rUD
 W57wIExjNAnNn717fAneRg6cOZDBYZnHU30dJCJ93N4CHXYyYgCmJl8vJG1jAB2RUMaNr+4Wf
 LLQ+RhNXEd8WpeJYpxM7HOFK0Bd6+g9GmnxnTOGQIwDWW1HQPtdOM/klvV/ZpSqc3NHbKYxte
 7D91FWHFWq7k0ireeOF9e+niBccNecpcCD3diPHSD8zOpshz/Plfw06yTkcQBm9VI6JBR+ygG
 WbWFK6LQiGP6YlfTi8XvH4SFwP6oYPenZinTyPQ4cryG6NkF8RO2jY/Z/4SZM9gQqPIGU3ND1
 b6f63ZgoabNl1sld7y5Y5pHmMPKcpkW7g20oKG1zS+DtE+LPlW398rAoGr9Bwq8VIWvjAgLRV
 RrSlCTPxC4m1iRU9kgedpjuKJuWwIcgjR/FElZ63ZjXs3rVjrsGLra/MZLcE51e4Spob7KF1y
 2Nzq3rfuwRKXL0z7XZMYP1iARA1BBai56dKnqY80pUEdPx9RrQEA4y5cc5OU8QTfAug+JIqxh
 /A1E3nF1ZAFenPAfjgcl7OPUOzwB4bt4U1/qH0vJk9W52Il6zLQOXgW5dgRirrUYGQ1fDnDj/
 2QHBq+acTKZGm0TJdlN+AWDQ==
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



Am 29=2E Oktober 2024 16:45:29 MEZ schrieb Simon Glass <sjg@chromium=2Eorg=
>:
>Hi Ilias,
>
>On Tue, 29 Oct 2024 at 11:02, Ilias Apalodimas
><ilias=2Eapalodimas@linaro=2Eorg> wrote:
>>
>> Hi Simon,
>>
>> On Mon, 28 Oct 2024 at 14:48, Simon Glass <sjg@chromium=2Eorg> wrote:
>> >
>> > Freeing a NULL pointer is an error in EFI, so check the pointer first=
,
>> > before freeing it=2E
>> >
>> > Signed-off-by: Simon Glass <sjg@chromium=2Eorg>
>> > ---
>> >
>> >  lib/efi_loader/efi_bootmgr=2Ec | 3 ++-
>> >  1 file changed, 2 insertions(+), 1 deletion(-)
>> >
>> > diff --git a/lib/efi_loader/efi_bootmgr=2Ec b/lib/efi_loader/efi_boot=
mgr=2Ec
>> > index a3aa2b8d1b9=2E=2E431a38704e9 100644
>> > --- a/lib/efi_loader/efi_bootmgr=2Ec
>> > +++ b/lib/efi_loader/efi_bootmgr=2Ec
>> > @@ -1180,7 +1180,8 @@ out:
>> >                         free(opt[i]=2Elo);
>> >         }
>> >         free(opt);
>> > -       efi_free_pool(handles);
>> > +       if (handles)
>> > +               efi_free_pool(handles);
>>
>> We don't need this, efi_free_pool() checks the pointer already=2E
>
>Yes, but it then returns an error (EFI_INVALID_PARAMETER), which gets
>logged, with this series=2E

So this is not a problem of the existing code but of your patch series whi=
ch creates a superfluous log message=2E

Best regards

Heinrich

>
>Regards,
>Simon
