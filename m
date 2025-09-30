Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9822CCCA470
	for <u-boot@archiver.kernel.org>; Tue, 30 Sep 2025 14:09:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E0EFB81D6A;
	Tue, 30 Sep 2025 16:09:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="nwTwyx34";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D6AD883071; Tue, 30 Sep 2025 16:09:46 +0200 (CEST)
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com
 [IPv6:2607:f8b0:4864:20::732])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C937A802C1
 for <u-boot@lists.denx.de>; Tue, 30 Sep 2025 16:09:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=javier.tia@linaro.org
Received: by mail-qk1-x732.google.com with SMTP id
 af79cd13be357-8593bcdd909so626022185a.3
 for <u-boot@lists.denx.de>; Tue, 30 Sep 2025 07:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759241382; x=1759846182; darn=lists.denx.de;
 h=content-transfer-encoding:subject:references:in-reply-to:message-id
 :cc:to:from:date:mime-version:feedback-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GhLskseidjt0JGKTWba24DbbjIgpMpOpjZsKSwYVOCY=;
 b=nwTwyx34mfpw/3nmKPjLWSvy1aTetUNBFgoO2STXjsVdj0vT6S7OBYidPHbBAaWnbJ
 YNMIgDmHzY0F3HHKxUEiGXslpwcsPsOr6602omJ3QRyf2XWRBwRQs3ijcholu58TlK8B
 fo4LDV9gF9S8pgIX+V5vqIu0jXaV9/87LlS5QMZKNzFTJa8CZeAkXJE+8wnfu2Uq3kSa
 P2q3FUVjh460v7UzCxiEkD9rykukrmePXnTbFzs15goHmYfIAkTDOWr4ArxpdOdIV7S4
 IlsPtuw4UV1saq1term8mO+aI3l8L5MeocFjzCckogX2WtAUDTkepyHRG0L6D/OqiO2t
 GJhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759241382; x=1759846182;
 h=content-transfer-encoding:subject:references:in-reply-to:message-id
 :cc:to:from:date:mime-version:feedback-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=GhLskseidjt0JGKTWba24DbbjIgpMpOpjZsKSwYVOCY=;
 b=OGv5PlNsIv0fhfqQwLeJLvOIBvnYdXkUuVJwYcADxZVOeBu9dviCyU+uML/1zccr9Q
 JpiAvO6fPgVlefS8gpshzQM+8Sh5pNQl8zB1ZaPijPCdQg9YIMhXp2T5jHJsONpqIfDS
 b/B+vy0xikGhB8x8P2XF2Ky8M4OAC87BbeZ5MIKNmouEMfdEWX0VGtoh5j8x+2Cj4WRK
 JZUcf6+vvkIDixheItRG4kt+deO43M3sV/AuwV0lv4/ifApT7n8iN9Ep3Ao8BlzAxWBO
 BGLT+v14j7gntuYwQNqPD4XYCJe0UAj701okNDJaP0Crqs13+UAOGtjZ2cRX1OwOpF1s
 u6cw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWjY/cGt27fGIYjpiJXcFrj3q+5v7CquurQayYNNjVtV4RHyiWXivXBNxO8mIEU5SXkI2WsWXY=@lists.denx.de
X-Gm-Message-State: AOJu0Yz72uxt9gN0Kvq2V/sFshRjbcLUXQH028jYRxd1eMTkhHAAzuiM
 ZogsChjgRUhqO9zLVxjz7GqQFoaIE4aIfyjKpxlPym8skSLQf9GmMMSzLajGP7ZXcStWtfiU6J8
 0cRnX
X-Gm-Gg: ASbGncsINfYcOzcd5GDmDUrVSJPv+OolixQtnMRVlaRyPoCGkV4UgW9zx+1lpnqwD3e
 pW59wudRI8o2KaealixTzq8E5JrPBzkk4ZaVXQU2Qg7Bmq+EzRxFUfIHgqouDIQUDPNoqkxx0gt
 LB0g8Q7yjwKIqHzBR98f5pbZBN57doOfBHO7y0+3SROJEwk8TByM++QgOUaKnqyfnp08f5RmVaV
 FnV9q4PyoOs4hhB/xMPL+eAtmPxL3Y303i5SVnkMSTXiNr2xlQ+jFaNvvsZN65p3KUz9avmxzyi
 PLYfqDnENqWSdEMcrV2+O1koK09kswOtYiPKrKqKoYXFZv/bR0YXc4Fui0eblPYZibjoL5UDKQo
 ZFW7aHY511XS0E6T19xUMp9QswSkMGLos5yN53uDodNoQOikYAsW7mqbDNwUPgOtD0gSVgY8/Qf
 cStYIpM3Wcxids99N9uSc7e2Zwi03GJGO2x9lVlA==
X-Google-Smtp-Source: AGHT+IE2s39AyszoW2KA+ERYszRc7U3vazQW91vieufhPiDFS/ML9JsLYbu49GOhbbJiGSURLKl+Mg==
X-Received: by 2002:a05:620a:2a03:b0:862:bd48:9227 with SMTP id
 af79cd13be357-862bd4892c7mr1899188285a.75.1759241382269; 
 Tue, 30 Sep 2025 07:09:42 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com
 (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-85c28a8a7b5sm1058932585a.26.2025.09.30.07.09.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Sep 2025 07:09:41 -0700 (PDT)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfauth.phl.internal (Postfix) with ESMTP id 57F53F40068;
 Tue, 30 Sep 2025 10:09:41 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
 by phl-compute-05.internal (MEProxy); Tue, 30 Sep 2025 10:09:41 -0400
X-ME-Sender: <xms:peTbaDVLqBTgG-_ZVgAyDtc2IUfXfKp5nD-WUWqgQpsyJ4c0ybcn2Q>
 <xme:peTbaGZ3pCW9ZEb-KS-yUqt-7b7wFcvrDWYDYzzW3IjBASJ7dRlJWVIEHlMZIAjzz
 9n24nzxR1cnkGEPumZ2JCQTOufRBGVeqtsbBu3gjkpFoPKEbPj8qKQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekuddtjecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdflrghvihgv
 rhcuvfhirgdfuceojhgrvhhivghrrdhtihgrsehlihhnrghrohdrohhrgheqnecuggftrf
 grthhtvghrnhepieehudekiedvueeuvefgieegveevgeeltedtkefghefhheetfeevffeg
 tdeuvdehnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpuhdqsghoohhtrdhorhhgpd
 hphihthhhonhdrohhrghdpghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgep
 tdenucfrrghrrghmpehmrghilhhfrhhomhepfhgrshhtmhgrihhlodhmvghsmhhtphgruh
 hthhhpvghrshhonhgrlhhithihqdduhedvkeekleehkeefqdefudefieegvdeliedqjhgr
 vhhivghrrdhtihgrpeeplhhinhgrrhhordhorhhgsehjvghtmhdrmhgvpdhnsggprhgtph
 htthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmkhhorhhpvghrshhh
 ohgvkheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhrihhniheskhhonhhsuhhlkh
 hordgtohhmpdhrtghpthhtohepnhgvihhlrdgrrhhmshhtrhhonhhgsehlihhnrghrohdr
 ohhrghdprhgtphhtthhopehuqdgsohhotheslhhishhtshdruggvnhigrdguvg
X-ME-Proxy: <xmx:peTbaA_e-LPyj3V6In1ZBzAeLeriMl5kKG-IdHybbb9fjTqQJKAZmQ>
 <xmx:peTbaGgUbMlNwWe2WHnMyEvq07cUcBKe8KlK28AFa2IuKdWPVeiTLQ>
 <xmx:peTbaAdWe4pLCqXJd3tHYJCUWjspgGiNjqUfBPi8_rn4VUNfMf1GfA>
 <xmx:peTbaNo42HSDopoyrZ8pxUu3yjrFIeJgEzsXP6cAaaxmIvxqiuqj-w>
 <xmx:peTbaFAkBwDu-BEstMkslYNkOJ6ZY3j4IIDt-Aj-hPGSEcj1lfyi2pjP>
Feedback-ID: idd3648b2:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
 id 1D8F51EA0068; Tue, 30 Sep 2025 10:09:41 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
X-ThreadId: AMtrVltxD7sc
Date: Tue, 30 Sep 2025 08:09:05 -0600
From: "Javier Tia" <javier.tia@linaro.org>
To: "Mattijs Korpershoek" <mkorpershoek@kernel.org>, u-boot@lists.denx.de
Cc: "Tom Rini" <trini@konsulko.com>,
 "Neil Armstrong" <neil.armstrong@linaro.org>
Message-Id: <3f5986c7-918d-4c22-ab65-7d3017cdf8cb@app.fastmail.com>
In-Reply-To: <87cy78hyhz.fsf@kernel.org>
References: <20250930-b4-docs-v3-1-1fbf094347a8@linaro.org>
 <87cy78hyhz.fsf@kernel.org>
Subject: Re: [PATCH v3] doc: Update coding style to recommend b4 for patch
 submission
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

Hi Mattijis,

On Tue, Sep 30, 2025, at 7:16 AM, Mattijs Korpershoek wrote:
> Hi Javier,
>
> On Tue, Sep 30, 2025 at 06:53, Javier Tia <javier.tia@linaro.org> wrot=
e:
>
>> Replace references to patman with b4 as the recommended tool for
>> preparing and sending patches. b4 is widely adopted in the Linux kern=
el
>> community and U-Boot ships with configuration to simplify its use with
>> the project mailing list.
>>
>> The updated guidelines describe how to prepare series with b4, handle
>> cover letters and recipient lists, run style checks, and send patches
>> safely. Instructions also highlight how to collect and apply review t=
ags
>> before resending.
>>
>> This change documents the preferred workflow for contributors and
>> ensures consistency with common practices across related upstream
>> communities.
>>
>> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
>> Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
>> Signed-off-by: Javier Tia <javier.tia@linaro.org>
>> ---
>> This small series updates U-Boot's contributor guidelines to sync with
>> current best practices around Linux kernel patch submission. It should
>> make contributing smoother for new developers.
>>
>> The first patch updates doc/develop/codingstyle.rst to recommend the =
b4
>> tool instead of patman as the standard workflow for preparing and
>> sending patches. The revised documentation explains how to create and
>> manage series, run style checks, handle cover letters, discover maili=
ng
>> list recipients, and collect review tags. This reflects widespread
>> adoption of b4 in the Linux kernel community and ensures U-Boot
>> contributors follow consistent, upstream-friendly practices.
>> ---
>> Changes in v3:
>>
>> * Update trailers
>> * Link to v2: https://lore.kernel.org/r/20250929-b4-docs-v2-1-478285f=
08639@linaro.org
>
> No need to re-send a new version *only* for updating the trailers.
> The maintainer (custodian) who will pick up this patch will do that for
> you. See:
>
> https://docs.u-boot.org/en/latest/develop/process.html#work-flow-of-a-=
custodian

Thank you for pointing it out. I read it before, but at that time it was=
 not clear for me if updating the tags or trailers was a task for the co=
ntributor or custodian.=20

>>
>> Changes in v2:
>>
>> * Drop commit changing .b4-config
>> * Link to v1: https://lore.kernel.org/r/20250929-b4-docs-v1-0-a56c1a1=
856c5@linaro.org
>> ---
>>  doc/develop/codingstyle.rst | 54 +++++++++++++++++++++++++++++++++++=
+++++-----
>>  1 file changed, 48 insertions(+), 6 deletions(-)
>>
>> diff --git a/doc/develop/codingstyle.rst b/doc/develop/codingstyle.rst
>> index bc18b2ebb7b0fc875a299b9e2e5c64c3d6a8e2b3..8ed6babe4556423fe30ef=
fc504615e07a841f21a 100644
>> --- a/doc/develop/codingstyle.rst
>> +++ b/doc/develop/codingstyle.rst
>> @@ -23,13 +23,55 @@ The following rules apply:
>>    <https://peps.python.org/pep-0008/>`_. Use `pylint
>>    <https://github.com/pylint-dev/pylint>`_ for checking the code.
>> =20
>> -* Use patman to send your patches (``tools/patman/patman -H`` for fu=
ll
>> -  instructions). With a few tags in your commits this will check you=
r patches
>> -  and take care of emailing them.
>> +* Use the `b4 <https://git.kernel.org/pub/scm/utils/b4/b4.git/>`_ to=
ol to prepare and
>> +  send your patches. b4 has become the preferred tool to sending pat=
ches for many
>> +  Linux kernel contributors, and U-Boot ships with a ready-to-use ``=
.b4-config`` that
>> +  targets ``u-boot@lists.denx.de`` and integrates with ``scripts/get=
_maintainer.pl`` for
>> +  recipient discovery.
>> =20
>> -* If you don't use patman, make sure to run ``scripts/checkpatch.pl`=
`. For
>> -  more information, read :doc:`checkpatch`. Note that this should be=
 done
>> -  *before* posting on the mailing list!
>> +  Start a topical series with ``b4 prep`` and keep the commits organ=
ised with
>> +  ``git rebase -i``. ``b4 prep --edit-cover`` opens an editor for th=
e cover
>> +  letter, while ``b4 prep --auto-to-cc`` collects reviewers and main=
tainers from
>> +  both the configuration file and ``scripts/get_maintainer.pl``.
>> +
>> +  .. code-block:: bash
>> +
>> +     b4 prep -n mmc-fixes
>> +     git rebase -i origin/master
>> +     b4 prep --edit-cover
>> +     b4 prep --auto-to-cc
>> +
>> +  Run the style checks before sending. ``b4 prep --check`` wraps the=
 existing
>> +  tooling so you see the output from ``scripts/checkpatch.pl`` along=
side b4's
>> +  own validation. You can always invoke ``scripts/checkpatch.pl`` di=
rectly for
>> +  additional runs.
>> +
>> +  .. code-block:: bash
>> +
>> +     b4 prep --check
>> +
>> +  When the series is ready, use ``b4 send``. Begin with ``--dry-run`=
` to review
>> +  the generated emails and ``--reflect`` to copy yourself for record=
s before
>> +  dispatching to ``u-boot@lists.denx.de``.
>> +
>> +  .. code-block:: bash
>> +
>> +     b4 send --dry-run
>> +     b4 send --reflect
>> +     b4 send
>> +
>> +  After reviews arrive, collect Acked-by/Tested-by tags with ``b4 tr=
ailers -u``
>> +  and fold them into your commits before resending the updated serie=
s.
>> +
>> +  .. code-block:: bash
>> +
>> +     b4 trailers -u
>> +     git rebase -i origin/master
>> +     b4 send
>> +
>> +* Run ``scripts/checkpatch.pl`` directly or via ``b4 prep --check`` =
so that all
>> +  issues are resolved *before* posting on the mailing list. For more=
 information,
>> +  read :doc:`checkpatch`.
>> =20
>>  * Source files originating from different projects (for example the =
MTD
>>    subsystem or the hush shell code from the BusyBox project) may, af=
ter
>>
>> ---
>> base-commit: 26efc940c865a04d345ac9d39f71746fc2821da6
>> change-id: 20250929-b4-docs-60da5560f06a
>>
>> Best regards,
>> --=20
>> Javier Tia <javier.tia@linaro.org>

--=20
=C2=BB Javier Tia =E2=9C=8D
