Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00590606A31A
	for <u-boot@archiver.kernel.org>; Fri, 23 Oct 2026 11:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=r/OqztEe;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a+Inc3no
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B804781202;
	Fri, 23 Oct 2026 11:35:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jBEQR0Dr5DQX; Fri, 23 Oct 2026 11:35:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 9DADC811D7
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792755350;
	b=qQ/3r6AL2U6RFUHdgOTAmGoAemoWOk5s95k1xQsR5I03eSLKpBMUq3ol7zjPHCxRr45k
	 LyRUiPkroClnJnWCeLFtduXWg2el2MxqbUAK5GvbBfynV+l5prFJRI7DRdeAACKnEFXad
	 tokNjo9GIUlvETCs2psNTCrIrnmVJr1iId/Bkc94q/nv/WIFG5yqotxskuJk2HPl4feHp
	 hyaTqzjKMqUXdsjp23d7j9p/KNGfZr3gMPT1W1/0JFmymq/cXjRX6vOBtm+r9ee/PlYCx
	 Jgxyn997k2YkQheRzq6JzQLxhtV1dkSqapmxOS9gkS8BYwwPCk9rqHqrjzLUIoURMtA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792755350;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=aaM/K+9Z4xl6aeCMkZbn4KlmSr2iq8x/qZ98Kk3S7ho=;
	b=DJKHRaPkRACMEkFvUhFR5oNmhM/rRRX+mNN/05lykNogg5Q2G9C+yaCGxm7AtI4vRFqc
	 L+RB/nCpt1p8eTu2T3wdIaaDpTWVT5rl6UL9vNb1wZlVn/XSQ3pafdIIGmtaWBLAg5OGC
	 IeFTQnComXPXajlInwPmhuJxkPbuONpjU44DnENM+BpooXNFESPb3gjdJIlacUnVbfA4q
	 6rpTHfBvRgeYfMUTXqUwGtLlQ1fa/e4MjAkwVJOTYBFrlPsSDWcs6ttObFPe0rNHOInIK
	 Iy5rnC9s+y6JMCc+pKUO3EEq68nsC6RXNeQfU+nlC7let6qMWUFOegkc9k1+rhYgBbg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792755350;
	bh=aaM/K+9Z4xl6aeCMkZbn4KlmSr2iq8x/qZ98Kk3S7ho=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=r/OqztEeWd6uaK/cLS7DoV+BQhUGLk9AbFuQ2p09+NlS4VT1ipiQMV6SVPqL0cWaG
	 NNRJqV2Xe5vRR/m7DMsuG//KaVI2wQiKkPWS1ycoMBvVvZ45ZkwZqKuCk/W1ANt3ra
	 Fys9q5RLu3dcXHMILMH5gF/0th5JQRhPNiAJlHhERyJzR+efLsAJE06PB4T3BWcJ++
	 4wdbaT/ZIhCvnQeuUH015HTOdC4uGc80ivQ+qvOqkK70ribzbOJTp6hVNqZWrJpF+F
	 a9yNMiuadES541CFQ1+WIxPCOMuqm+gpgsgU7J8Fm0cJu0IL3Pn/u+/jqlKW63W2+N
	 9jh0c6KGbCB1w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9DADC811D7;
	Fri, 23 Oct 2026 11:35:50 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 18B233AF
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 11:35:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id F29A9408B3
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 11:35:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XuzfdXUDqSra for <u-boot@lists.u-boot-project.org>;
 Fri, 23 Oct 2026 11:35:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org AFE83408AB
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792755348;
 b=g4kvVB1UX1Lq8bIFHentq1JVSbES4wx1fE2BjqE0jRnPuQBu2HWfxS4B/R3Hnnu7fDvZ
 oyg5VxapPlL5qaxxCTOvZCs6Ox1zvjYZyZ/3Fq9xM/UOwEuJ4Tt2CyQia4CBvfmE1Tg7C
 AXSqwyKMHkGwLnf1b28oxqLLYueJs97+F413uEwEcXgOg6jrDKVciv/DmgLJpz0zVMm9A
 Is6AACBl4k0bBVtUpHCISakXXJHAUI9YSwLcOTSBPfvMxwT1o/lKWtc6fQsUChPKWuUqi
 s3bH/3EdcYOF0vT62T/7PRaEcM10MTeHhkM5K7GXrTQD+6OYGvy81okn6AGnwnc6qoA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792755348;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 In-Reply-To:References:Date:Message-ID:MIME-Version:Content-Type:
 Content-Transfer-Encoding;
 bh=aaM/K+9Z4xl6aeCMkZbn4KlmSr2iq8x/qZ98Kk3S7ho=;
 b=LF+j0CoCIG6qmCb5Dvo12da2cP1bIjYjeyz0M9g10ARUU1FnqqzM6ruvfoTUdzxt44I2
 6B0LrZ0VZT8YBIj2vqQvQ3hbMTYLd9yzXrfMKLJfN+DR0XTo03iHWuCN4DZVI2x5UPnuH
 ALhbvpcAYRbjOUlEW5mskqZ8p6EZgHhHv0bRJwE6RQ9CW+xOuSR0SeupRqOH+/YWfbR/7
 ZdwY+ThtTjJsu77khJJY5tIObhZV0hMG0rMNSrixjahvME10ZmeP2cPP0UldcleaeQYlG
 MqB987O1fNvRTPEG4gy+QrUDJqbedGFcDe18/qS0u3DyGBckB7J5EEug3ornLA+3KLQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=a+Inc3no; 
 arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=mkorpershoek@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=a+Inc3no
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp4.osuosl.org (Postfix) with ESMTPS id AFE83408AB
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 11:35:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 59F75601DE;
 Fri, 23 Oct 2026 11:35:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FD431F01825;
 Fri, 23 Oct 2026 11:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792755344;
 bh=aaM/K+9Z4xl6aeCMkZbn4KlmSr2iq8x/qZ98Kk3S7ho=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=a+Inc3noCPjc1kS4Z8I15RAOCP/hyiRN7lfiDZMtLXLbVc5ORk6lze6AIZmcAowHL
 0FW4OE+ui2IZeVLttePgVE7lnc2NXaIp6EpSRE8ojR88xZEqkI4Obpm3Vm9OtrBx/1
 3THixAMcTE55XSQkDZ2YxnFJ9hFxuab4e1OKQ/jGlIhvlwd5mmpaAj7UgU4zlI+Gyi
 FZvHWaSe4ZNa++cp8V+QdDSUAIyj4RDd2C+GWu1COrG1E63HYLHQD0kzpvT5QDk7Ds
 DV/D3JD7CH1niXGJKvWjTwsll38rtGkK0QKAkuX40wBrafTivU9rtCDoRsYyjmSU9i
 lIdii7lZT49sQ==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: u-boot@lists.u-boot-project.org, Igor Opaniuk
 <igor.opaniuk@oss.qualcomm.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, Shahriyar
 Jalayeri <shahriyar@byteray.co.uk>, Quentin Schulz
 <quentin.schulz@cherry.de>, Pengpeng Hou <pengpeng@iscas.ac.cn>, Marek
 Vasut <marek.vasut+renesas@mailbox.org>, Ahmad Fatoum
 <a.fatoum@pengutronix.de>, Guillaume La Roque <glaroque@baylibre.com>, Jan
 Kehren <jan.kehren@emteria.com>
Subject: Re: [PATCH v4 0/5] avb: device lock state, root key provisioning
 and in-place verification
In-Reply-To: <179275217876.886736.6937155990522210284.b4-ty@b4>
References: <20261022-upstream-avb_lock_unlock_b4-v4-0-f4926ca925e7@oss.qualcomm.com>
 <179275217876.886736.6937155990522210284.b4-ty@b4>
Date: Fri, 23 Oct 2026 13:35:41 +0200
Message-ID: <xhkdb1p9gps36.fsf@mkorpers-koolstof.csb>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Igor,

On Fri, Oct 23, 2026 at 12:42, Mattijs Korpershoek <mkorpershoek@kernel.org=
> wrote:

> Hi,
>
> On Thu, 22 Oct 2026 21:04:41 +0200, Igor Opaniuk wrote:
>> This series completes the device state handling of the AVB 2.0
>> implementation when the state is kept by the OP-TEE AVB TA, and fixes
>> the way the Android bootmeth hands the boot images to libavb.
>>=20
>> Patches 1 and 2 add the shell side: "avb read_pvalue_hex" and
>> "avb write_pvalue_hex" provision binary persistent values such as the
>> SHA-256 digest of the vbmeta signing key that CONFIG_AVB_ROOT_KEY_TEE
>> consumes, and "avb lock"/"avb unlock" set the lock state through a new
>> avb_write_lock_state() helper. Until now U-Boot could only read the
>> lock state, so a device backed by the TA could never leave the unlocked
>> (orange) state.
>>=20
>> [...]
>
> Thanks, Applied to https://git.u-boot-project.org/u-boot/custodians/u-boo=
t-dfu (u-boot-dfu)
>
> [1/5] cmd: avb: add read_pvalue_hex/write_pvalue_hex
>       https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu/-/commi=
t/ae7f94107cf9a1a83799034b1e4165fe49e6d8a7
> [2/5] cmd: avb: add lock/unlock commands
>       https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu/-/commi=
t/08d45d705a740c63791441f4b8e0a612dddf15cd
> [3/5] avb: verify the boot images in the buffers they are booted from
>       https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu/-/commi=
t/5f6530505fdc0fc01f2df1363febc338fdfbf709
> [4/5] fastboot: add flashing lock/unlock/get_unlock_ability
>       https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu/-/commi=
t/c69982f9c9ec2b3f2d91dc9c49e9971f9fe3664a
> [5/5] doc: android/avb2: document the root key provisioning and lock state
>       https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu/-/commi=
t/2d105e34525ff9b0c3ee8c434781e5c9ff807b4d

This series fails CI on sandbox_spl test.py:
https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu/-/jobs/123953

"""
Building current source for 1 boards (1 thread, 16 jobs per thread)
   sandbox:  +   sandbox_spl
+drivers/fastboot/fb_command.c:302:13: error: =E2=80=98boot_image=E2=80=99 =
defined but not used [-Werror=3Dunused-function]
+  302 | static void boot_image(char *cmd_parameter, char *response)
+      |             ^~~~~~~~~~
+cc1: all warnings being treated as errors
+make[4]: *** [scripts/Makefile.build:272: spl/drivers/fastboot/fb_command.=
o] Error 1
+make[3]: *** [scripts/Makefile.build:497: spl/drivers/fastboot] Error 2
+make[2]: *** [scripts/Makefile.xpl:552: spl/drivers] Error 2
+make[1]: *** [Makefile:2462: spl/u-boot-spl] Error 2
+make: *** [Makefile:189: __sub-make] Error 2
    0    0    1 /1              sandbox_spl
"""

Can you have a look please?

If you resend a new version, can you also please rebase on u-boot-dfu ?
I had some conflicts when applying PATCH 4 (I fixed when applying but
i'd prefer to have a clean pick instead)

Thanks
Mattijs

>
> --
> Mattijs
