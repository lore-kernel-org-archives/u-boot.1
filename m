Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D328D0D16B
	for <u-boot@archiver.kernel.org>; Wed,  7 Jan 2026 19:14:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 070C483A91;
	Wed,  7 Jan 2026 20:14:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="AKAH7Cgt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DFAF783B21; Wed,  7 Jan 2026 20:14:12 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D5AC583A2B
 for <u-boot@lists.denx.de>; Wed,  7 Jan 2026 20:14:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1767813246; x=1768418046; i=xypron.glpk@gmx.de;
 bh=qs8FQi3Gqkd3jMlyqrMp4xb88bQb/XYBDCXoESiVEQo=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=AKAH7CgtPeiBmsVh9BqrPp3Uw9gARvvndmM4Cs31/yhsgIdpjcTtetcgo0C+68/x
 K+C1nS7+OZwVMQmG8QbKqU+NHGo4FmNatt5afkgYmzzkLKptst/+rp1mUm3unWsg7
 ckXjKFq0AZyXeoynq8g8wPnQZDJtOnp/EF1DKU+2u3ToSlPxplFb3lxhbP+XA4WbR
 DWd20rUDyrWmVgzBk2jkccsQ1GTi3kRhvDPr3FBGIBq5iQ9k8OCfubyZxSbQJfwCI
 Aszqes3qpTn4hIkKBCsjD6HSCloCVt1y1eYusf0lS6lsYHgMXpjffdqWJ3QllOaP5
 mpCeBt9DLZlz9hQADQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from ehlo.thunderbird.net ([5.147.80.91]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MQMuX-1vHtMN0ycj-00JJ3p; Wed, 07
 Jan 2026 20:14:06 +0100
Date: Wed, 07 Jan 2026 20:14:05 +0100
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Simon Glass <sjg@chromium.org>
CC: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Simon Glass <simon.glass@canonical.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Subject: Re: [PATCH 05/10] bootm: Do bootstage processing in bootm_final()
User-Agent: Thunderbird for Android
In-Reply-To: <CAFLszTi-gRmj2YtHfG2F3u0feNMcC1+h5hwAvNTYJ+xC1JQnJA@mail.gmail.com>
References: <20260107003131.3064800-1-simon.glass@canonical.com>
 <20260107003131.3064800-6-simon.glass@canonical.com>
 <B1959B8B-8D25-499B-B1E8-02178F67A191@gmx.de>
 <CAFLszTi-gRmj2YtHfG2F3u0feNMcC1+h5hwAvNTYJ+xC1JQnJA@mail.gmail.com>
Message-ID: <7E049032-1F4E-464A-801C-468C8A9AC67B@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:RLGffWWOzgJ7xel+SwQhruls+a2hUzCo1ozgwIK/uX5vknxITiT
 L506It6HZYnHrgg2zDu5ECkKbozmFwyRy537wTjPB3Q1nVFaRMEa+YR1kV2QV9OhyH73jkp
 adw8gj4KlliB6ECDavYRAchNrN1CzAV3NIoXAAxnGiu3uqH2cC7oJVoiP/JiIuZcfAh07lT
 qtMzHgzqxAiFqMxlIchcw==
UI-OutboundReport: notjunk:1;M01:P0:nE/x8MDmiHA=;m4PJyXflbPmAp41MQRJzvcx8uKE
 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
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

Am 7=2E Januar 2026 20:02:39 MEZ schrieb Simon Glass <sjg@chromium=2Eorg>:
>Hi Heinrich,
>
>On Tue, 6 Jan 2026 at 20:58, Heinrich Schuchardt <xypron=2Eglpk@gmx=2Ede>=
 wrote:
>>
>> Am 7=2E Januar 2026 01:31:22 MEZ schrieb Simon Glass <sjg@chromium=2Eor=
g>:
>> >From: Simon Glass <sjg@chromium=2Eorg>
>> >
>> >Mark kernel start before booting=2E If enabled, show a bootstage repor=
t=2E
>> >
>> >Signed-off-by: Simon Glass <sjg@chromium=2Eorg>
>> >Signed-off-by: Simon Glass <simon=2Eglass@canonical=2Ecom>
>> >---
>> >
>> > boot/bootm_final=2Ec   | 6 ++++++
>> > test/boot/bootflow=2Ec | 2 +-
>> > 2 files changed, 7 insertions(+), 1 deletion(-)
>> >
>> >diff --git a/boot/bootm_final=2Ec b/boot/bootm_final=2Ec
>> >index 71661334e11=2E=2Edd7cac55f1e 100644
>> >--- a/boot/bootm_final=2Ec
>> >+++ b/boot/bootm_final=2Ec
>> >@@ -6,11 +6,17 @@
>> >  */
>> >
>> > #include <bootm=2Eh>
>> >+#include <bootstage=2Eh>
>> > #include <dm/root=2Eh>
>> >
>> > void bootm_final(enum bootm_final_t flags)
>> > {
>> >       printf("\nStarting kernel =2E=2E=2E\n\n");
>>
>> This noisy message makes no sense for EFI booting=2E The kernel in not =
started in ExitBootServices()=2E
>
>Can you explain that a bit more? I believe that's exactly when the
>kernel starts=2E
>
>>
>> Operating systems like Ubuntu tend to boot the kernel with argument "qu=
iet" for aesthetic reasons=2E We should not disrupt this=2E
>
>When I boot (with this patch) I see these messages on the serial console:
>>>>
>Scanning for bootflows in all bootdevs
>Seq  Method       State   Uclass    Part  E  Name                      Fi=
lename
>---  -----------  ------  --------  ----  -  ------------------------
>----------------
>Scanning global bootmeth 'efi_mgr':
>  0  efi_mgr      ready   (none)       0     <NULL>
>** Booting bootflow '<NULL>' with efi_mgr
>      try_load_entry() Booting: Label: Ubuntu Device path:
>/HD(1,GPT,eccaac1c-b634-441b-a788-ab0f959111af,0x800,0x165800)/\EFI\ubunt=
u\shimx64=2Eefi

Here GRUB is running=2E If you don't see output, then because purposefully=
 it has been quieted=2E

>
>Starting kernel =2E=2E=2E

ExitBootServices is called in the middle of the Linux kernel EFI stub and =
not when entering the kernel=2E

Best regards

Heinrich

><<<
>
>So it is not silent today=2E The last line is the new one=2E Every other
>boot method writes this line=2E
>
>However, the video display is silent once grub has finished and I just
>noticed that this patch draws some pixels on the display, as if the
>EFI display is set to a different mode from what U-Boot expects=2E I
>suppose this is understandable, as grub has run by then and has
>probably changed the mode=2E
>
>So I wonder what would be best here=2E We don't support dynamic video
>sizing right now and I don't feel the urge to implement it just for
>this=2E Perhaps with EFI we could disable the vidconsole when
>exit-boot-services is called, on the basis that we cannot deal with
>whatever has happened to the display in the interim?
>
>Regards,
>Simon
>
>>
>> Best regards
>>
>> Heinrich
>>
>> >
>> >+      bootstage_mark_name(BOOTSTAGE_ID_BOOTM_HANDOFF, "start_kernel")=
;
>> >+
>> >+      if (IS_ENABLED(CONFIG_BOOTSTAGE_REPORT))
>> >+              bootstage_report();
>> >+
>> >       dm_remove_devices_active();
>> > }
>> >diff --git a/test/boot/bootflow=2Ec b/test/boot/bootflow=2Ec
>> >index a56435d053f=2E=2E80adc074070 100644
>> >--- a/test/boot/bootflow=2Ec
>> >+++ b/test/boot/bootflow=2Ec
>> >@@ -1381,7 +1381,7 @@ static int bootflow_efi(struct unit_test_state *=
uts)
>> >
>> >       /* TODO: Why the \r ? */
>> >       ut_assert_nextline("U-Boot test app for EFI_LOADER\r");
>> >-      ut_assert_nextline("Exiting test app");
>> >+      ut_assert_skip_to_line("Exiting test app");
>> >       ut_assert_nextline("Boot failed (err=3D-14)");
>> >
>> >       ut_assert_console_end();
>>
>
>Regards,
>Simon

