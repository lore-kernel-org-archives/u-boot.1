Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D42EBCA5FD4
	for <u-boot@archiver.kernel.org>; Thu,  1 Oct 2026 15:46:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 21A1860B26;
	Thu,  1 Oct 2026 15:46:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jlTxiFBgd1TL; Thu,  1 Oct 2026 15:46:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 76583607F2
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790869611;
	b=RdHYK9mCclM/DMHv86Ag+443ng8QaLIgrqKq9DlCpal79G4AzytVN0smo2n+0X4YDtL3
	 YCnUWatu4dUoTKOkwUz+JVDCjJ1BF5gaAUHUiXLOMMtWVRPo//EDD8/QEHrQjzE6fg15o
	 nfwEmepxBHyzzhsvBMWLFj+N2sCD/14tHNXWzKDLuJRwKHKTvwzyIHMXc37ERKHTxw8ul
	 8FpiaOwAO9p+AS4R03tmaiIwvLxTMbibKyWHiLDcgSk8213zg31kQhQXQL97kbgRnqC0b
	 /uKUqDFS1CMQgC8yNNU7cHS0rmYO7hqfymTsVnbZBKL1zQQIceCAVUumXt9KVaOXShA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790869611;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=eRf7ZgAMSCQa0UhXj0iIIZpZhJCsvv9l4PZKz1lQy7I=;
	b=cfmhcfTZ17c6p+xWFemwZ/dDggIsTdroCOLDyDPd2tP+GZ8KO25f5k9slPy7K0gqTa0y
	 I/jN+mT6F9wBp2mwcq+9zVQNNx56hTfh0cWDS3g4FIF17rOmY55ka8FvMEG+0n8KpFJu2
	 ahTcoJeXBoIVYeO1fWT2bIcZEHeK+SbC3J2VF13LuNct0DENIJFn6huAZVO/s2vJYYMcq
	 10m1mlYJKVMphbs/u0ZnfJxnpS6B7tBnnfct5U2f7TPwtKhub6aCj28bYrPu9pvsBnYFZ
	 lPH1cdGV4UD+oJOPy+jKjqT/o6J+gLdpAHzCYUdasOW25EFe4DEhqCBW479oxavXWZA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790869611;
	bh=eRf7ZgAMSCQa0UhXj0iIIZpZhJCsvv9l4PZKz1lQy7I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Vu7thLScP/lxlnI6DKHG5C1YeZ0eK05p6cuaYgda8FtMUdZEoaUCXEoCJaf6p3PMq
	 Hy95SO6i+ovX2sj9KQJz9M0KE0s3QvLjRMKn3Loh8GndB+Mx/Htq+NOUv6LT+/t6vJ
	 HFDa5xMIywobc0taxicy/y+Ftx1b/ZPq0CBd20LjKaA/PxFfq/xDrb6stxK43gFVOe
	 NIj52Yl7CCLzo7mVQelZEytQUVakaNElNPW73IHyzYBEydRJ8WkeVYztXq8b48NCeG
	 D2TiZ0P5wpTTkNLGTqWcQVU5JvDzO9s1RqPYehsLgZ2cXJhKHZFRulqCOgiY4hv3Z1
	 noUhzuTY/sZ7A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 76583607F2;
	Thu,  1 Oct 2026 15:46:51 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 93D97263
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 15:46:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9197740C9E
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 15:46:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zuiPTt4MVCpH for <u-boot@lists.u-boot-project.org>;
 Thu,  1 Oct 2026 15:46:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 4EB1B40CA8
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790869609;
 b=adT3jqxZGxNN44Bpj1Lu33mEt9D0VEpv93N09ScYn4fq0IoInvPrhEuPZDQVWHZA3dVd
 hkRR/2CQUkPKBSDparSlOEQd0yJvPzF3Hbgh62sAkZiCD1MRyc369ab2EAbotjKEUOrQ8
 PbcCraPW8tEOtB+SGfjOsQdpo/3pvbHPVvNPl9fVy2h9Fil51D1rlJU87A0LXovb56xLY
 KuM2dADagONyt77+dd4tFLOpwfeGMbbYAOBSPAeMLAq1b2yZh8dgLhYQwyEk6VfNsorBK
 omZ6Mm+IL0vS54QM+zmTZ3vCElnGAMO3TBpOzpGfpBaxCk5Sz46b3X/kAELkFqTnG0A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790869609;
 h=Received-SPF:Received:Received:DKIM-Signature:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:Content-Transfer-Encoding:In-Reply-To;
 bh=eRf7ZgAMSCQa0UhXj0iIIZpZhJCsvv9l4PZKz1lQy7I=;
 b=cnazZrlBi2RM6U1ddWF9FEJQaL/lMg7FSxQOVrLo2M6aSCfELLJ9EFPY8oUnL51Kha5b
 y6RYt98EDw2mOEfbM6QLyeAt9b9iyMv41di0ohxXsNooNAhPE93jRWd27jS37AIWu4J/q
 43l8n2A5Vgg0HjwOigbgdsyuizDuftGy8p3ORrj9vi/lj/EfJ5QoqeVaEdS21qyC9MJYh
 jstQQRCFAvkXCIqwRNlc1NkJ/TMtnumdS/cOizab8MM/gCQhfHZDhvAKQ+31s8ifCRaqs
 eguA3jHoTW5GJ+QiDWqwuh6F0zaJlU8Vcg9jJnndJmGnoYnHCK0YgbNL8lBBvs0S3gg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=arm.com; 
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss
 header.b=FyRSduO0; 
 arc=none smtp.remote-ip=217.140.110.172
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.140.110.172;
 helo=foss.arm.com; envelope-from=vincent.stehle@arm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=foss header.b=FyRSduO0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4EB1B40CA8
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 15:46:47 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 31C2A497;
 Thu,  1 Oct 2026 08:46:43 -0700 (PDT)
Received: from debian (X72Y076X74-2.nice.arm.com [10.34.129.17])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 139653F86F;
 Thu,  1 Oct 2026 08:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1790869606; bh=5w7T0H5/Vrfd4AMyAvfx0yfUK0gl0t9xkNuMo4dAovQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=FyRSduO0mGF7mh9s01RGM+czLC+44JxJNxG3gDcAYgRNZ6bPci4FY0w/DTJx4eF8+
 kZWlnpmOUsnqrFXGUvwpTJr+K6p02oK7jIw2SfK4/fZzSUeWNWsyfgJFYrm/AkIXev
 xg00XHkk0CPfWf8sMwlp+592SacR72bZh2wb6yMs=
Date: Thu, 1 Oct 2026 17:46:42 +0200
From: Vincent =?utf-8?Q?Stehl=C3=A9?= <vincent.stehle@arm.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.u-boot-project.org, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Sughosh Ganu <sughosh.ganu@arm.com>,
 Udit Kumar <u-kumar1@ti.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH 2/2] efi_selftest: add minimal fmp test
Message-ID: <ar6AYk2f_na162Ed@debian>
References: <20260922-authi-v1-0-e943530349bb@arm.com>
 <20260922-authi-v1-2-e943530349bb@arm.com>
 <CAFLszThhM2msTbVUmtAvaZzepE6qmb1w-GMb9SV5xYZY862BXQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFLszThhM2msTbVUmtAvaZzepE6qmb1w-GMb9SV5xYZY862BXQ@mail.gmail.com>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

On Thu, Oct 01, 2026 at 02:31:48AM +0100, Simon Glass wrote:
> Hi Vincent,

Hi Simon,

Thank you very much for your review.
I will send a v2 addressing all your remarks.

Best regards,
Vincent.

> 
> On 2026-09-22T14:58:39, Vincent Stehlé <vincent.stehle@arm.com> wrote:
> > efi_selftest: add minimal fmp test
> >
> > Add a minimal test for the UEFI Firmware Management Protocol.
> > At this point the test only does the following:
> >
> > - Get current firmware images info.
> > - For each image, verify consistency of the authentication flags.
> >
> > This can be tested on the sandbox with the following command:
> >
> >   ./u-boot -T -c "setenv efi_selftest firmware management protocol; \
> >                   bootefi selftest"
> >
> > Signed-off-by: Vincent Stehlé <vincent.stehle@arm.com>
> > Cc: Tom Rini <trini@konsulko.com>
> > Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> > Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> >
> > lib/efi_selftest/Makefile           |   2 +
> >  lib/efi_selftest/efi_selftest_fmp.c | 135 ++++++++++++++++++++++++++++++++++++
> >  2 files changed, 137 insertions(+)
> 
> > diff --git a/lib/efi_selftest/efi_selftest_fmp.c b/lib/efi_selftest/efi_selftest_fmp.c
> > @@ -0,0 +1,135 @@
> > +     /* Verify each image info */
> > +     for (i = 0; i < desc_cnt; i++) {
> > +             const struct efi_firmware_image_descriptor *inf = &img_info[i];
> 
> The spec says callers must step through the array using
> DescriptorSize, since firmware may return a larger (newer) descriptor
> than the one we know about. U-Boot happens to use sizeof(), but since
> this is a protocol test, please can you use desc_size as the stride,
> e.g. (void *)img_info + i * desc_size, and perhaps check that
> desc_size >= sizeof(*inf)?
> 
> > diff --git a/lib/efi_selftest/efi_selftest_fmp.c b/lib/efi_selftest/efi_selftest_fmp.c
> > @@ -0,0 +1,135 @@
> > +             /* Verify authentication */
> > +             if (CONFIG_IS_ENABLED(EFI_CAPSULE_AUTHENTICATE) &&
> > +                 (attr_supp & IMAGE_ATTRIBUTE_IMAGE_UPDATABLE) &&
> > +                 !(attr_supp & IMAGE_ATTRIBUTE_AUTHENTICATION_REQUIRED)) {
> > +                     efi_st_error("Bad AttributesSupported %u\n",
> > +                                  (unsigned int)attr_supp);
> > +                     goto out;
> > +             }
> 
> efi_firmware.c uses IS_ENABLED(CONFIG_EFI_CAPSULE_AUTHENTICATE), so
> please match that. There is no SPL variant of this option, so
> CONFIG_IS_ENABLED() just adds confusion.
> 
> This only checks one direction. You could also check that any bit set
> in AttributesSetting is also set in AttributesSupported, and that
> AUTHENTICATION_REQUIRED is not set in AttributesSetting when
> authentication is disabled. That would also catch regressions on
> boards without CONFIG_EFI_CAPSULE_AUTHENTICATE. What do you think?
> 
> > diff --git a/lib/efi_selftest/efi_selftest_fmp.c b/lib/efi_selftest/efi_selftest_fmp.c
> > @@ -0,0 +1,135 @@
> > +     ret = boottime->locate_protocol(&firmware_management_protocol_guid,
> > +                                     NULL, (void **)&fmp);
> 
> This only tests the first FMP instance. With
> CONFIG_EFI_CAPSULE_FIRMWARE_FIT and _RAW both enabled on sandbox there
> can be two, so using locate_handle_buffer() and checking each one
> would make the test more useful as it grows. I'm fine with leaving
> that for later though, since the patch says 'minimal'.
> 
> Regards,
> Simon
