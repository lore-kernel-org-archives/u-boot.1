Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DB39CA5FA1
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 17:13:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 61D1B80E85;
	Mon, 28 Sep 2026 17:13:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id U09QJyg1eOL9; Mon, 28 Sep 2026 17:13:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 882EA80EBB
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790615597;
	b=HtF2vX/m0TYbQaWC8PFCqYyb3182iOabrcrP9aR0Y3XROzCjfpwdcXowHCWUW0la+h5w
	 zOeS8ilqcwFuvRfpO/VnNWKfvkL3GE+n36Ps83FmDLlDuR7mnaPFcWxEKWls+qFKMKGRD
	 bQ6/4suketTysUd2sgVcCuMPa/j6bBz4ygID017m8hrhOEsaTocVJVOYmdIv4sESCZGuh
	 8qaVJAi2/kIrX7lIUtRslKEDuxx4wJt3DOwtS5wOnNgdrkZdpfr94fZVomDO7WYtr/wsH
	 lXwgin7vudrWonBqgr9cChP+N8NlD18U/HQfWK3LzvyGyg4Woj0d8DJ7T1WQ6+9rqYg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790615597;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=bCQrhpx093RxQ2Gwdj2M9JX2qUvfI4WWxI/ZkkyFOEo=;
	b=mIeNh3UJvfiCoKkNofL+LocLlSaQCf980z0eWMUF5/3PpdbyVKkgSHoPdYJzElyEYZCk
	 mGYR4n73Egcn5v7ikqgsdjl7h8v7d8S9Hcdyo4gIB0gVrlkEy6w3ftQ/Q/HxnN43/J4up
	 gdn+knxDzXCuRt18J9DodJnIa6zzYcA3GQu9FCY7WR7ZDMnms9vqPuvNiVuVRsTLTyhdt
	 bjBHzOgC30pWK48U+TpCG57Ewkvtjz42T6I7cbK3kIWsoW1AhDfvwV6gULrCM9FZNysH8
	 p5zFYxktmUJFSn/hy4erkCwbpHure0f46d3soEuENPifDQ0cJ5JtWdTygmzYZbZj14A==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; dmarc=pass header.from=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=XIOkeS9e;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790615597;
	bh=bCQrhpx093RxQ2Gwdj2M9JX2qUvfI4WWxI/ZkkyFOEo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hb6ER/d8tVI6JAqx4lVxMRLwRFSMPBsuscBTWKTavnodH599xFm0+OqvLsT7Ko9Rr
	 ITh6B1TqUN2EYpvbQrNcGzMgAWnQz3r6YsWXehvnbNluQpHTO4P8W9rDFIPhJvd4zK
	 SHoXuURKcWmiAWwyOy6lBhKSfkaBG2qG9am2VKh1K7RszDTLXGwW+ViRrMiZ0niQJ1
	 jda/3j8U28pkosgNYwXeOGAHlBH5NrXSW4ocWAv5H27scB2uLn+xX0nNxrKwY0NA2a
	 yz9X8wCbFKZDiByr6NprCP4cCrbAVqliXN+UA3LZqTbF1H87s3QeFtsb+7C/VJceVf
	 PAXcmGixqz++Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 882EA80EBB;
	Mon, 28 Sep 2026 17:13:17 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id D825E72
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 17:13:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BE26880DA9
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 17:13:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id g33qMhBkK2PC for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 17:13:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 1C29180DDC
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::630"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790615595;
 b=pu9Q1Z8nOFOZnZlK/7abx4kivFZmQR31Y7vKP0+aAY8/I8kyjJymxabT1x3VAcesDsZX
 gWrhlveRYXx8nQrM3JNKZDqpm+wlhS42F3+QK2IpmPBYru5ADeD62MvAcIQblDufR0ll/
 X7mYxMyAUSi9sShoyCX331fkQEBt+zgk+K0Tr7PJeW728LKVSSRdhy9lvwWuntAXSlUSe
 AKR63PpB9WFLuWb8zjytKFltMIEOlOWr0qlzU/cSOd2XPKXV72BqdPHMzKGhTfJfje4De
 vxXy4f7buP4J4Pw975QNCuil50L6Hz6redtiSHs7uM1jhK/wwu74P/OX05yu3m/cDDg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790615595;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=bCQrhpx093RxQ2Gwdj2M9JX2qUvfI4WWxI/ZkkyFOEo=;
 b=kO4+8DMwNki1n+lLaoFfWg4ijx1B16ZnqZa4IcmeojJyMpY9DEaqNoFAsUkK8ExRauSA
 0+PLRJejCf0AZoMDGLFX1b8EBHMRxuAWG5xrxrc4xj8kQ7WKpW6w/bLLbQktPuyRFv0EV
 IGupzBa5l1VkGBDk5s/N6rufhge6e8fObZIe2mqYQIu/FXQAmb+roRGFTDca2J7/wfZCN
 PYoJ+eqGD4OPLB6SGkG3GSYILn4sae1N9wByscwudEuuU1cqMCrY8JPQNJ8CQXAo4GDKl
 qeJAsxLW3l8BIb88lOSS4Pb2HHewgBuWIZhHga8Ed/46fHX5h8SZCzn8l6KHLB7uiwQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=chromium.org; 
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=XIOkeS9e; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::630"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::630; helo=mail-pl1-x630.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=XIOkeS9e
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com
 [IPv6:2607:f8b0:4864:20::630])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1C29180DDC
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 17:13:14 +0000 (UTC)
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2caced6038eso448115ad.0
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 10:13:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790615594; cv=none;
 d=google.com; s=arc-20260327;
 b=Gb+2ZGwJcH5rPGN3kyM7QaRAns+Rg+CvWYW3FK6W2dJT9RgVJYEbWvsqxvypl3FAMX
 M2E5EvrOzssY1G5NBWxsoQ7emznkH/d1vYZXFZZ89ZvsTCylXoz3CTUiMxDPR2kDRRcW
 kMzi/3jm3YJ6DmpUPgAoQl7Lsm3sTo4HDM1vXsfZ+qTg3X26dg3pd6iVs1SQwHqPfq3T
 SIJrutsFH3uVCzsrlmKe2vDs1FYpT6RyoBGXfiAEwuev2/BEUI7jIo+Gx+bbu904ySrh
 m92qRphwrM1D2xg4Hx6A/HJOgfGUMhP5lFkEsTnjxX8jhYpb6fNMZdOA2A2dVvi7FZzx
 93Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=bCQrhpx093RxQ2Gwdj2M9JX2qUvfI4WWxI/ZkkyFOEo=;
 fh=cUYNs/76oAu8JC8Dnt20Op7FjAkbyXpOSgmkHUekRa4=;
 b=RIn7AyUH3yyPihtR+abuVS3JHxZOlculX18v+BIFxtvQMg4TeNUB0eLrAihx8AoazW
 2vetwfnYvjBn3pFJEhDApRyIw3yQpnvsk2UvkdueIB79Z76EMpPnFibpI90Vz0atjTUU
 woeSP5OAYpAd8SHmTqhUarKR6ce/YbpalZTqlTMrEz5G37S/V/AvQ5FgV9GFOWoUtycB
 pMJR7ifz6zrUAcEAolUssb0E08MfKW0qsfZwsNyqZGrZc24YoUdb7+O+bUp+ZfYtCx8+
 SL86M/36z/746liEO7TwSO2vncvoyF8+iGwmnwqHbBWJwFnWGzf8OYMTvG3LLbXjL0V6
 JpEQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1790615594; x=1791220394;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=bCQrhpx093RxQ2Gwdj2M9JX2qUvfI4WWxI/ZkkyFOEo=;
 b=XIOkeS9eGRjFMRvAYJYXpZK/FnRE3kSjKgkxckqTR51Aw7A0bjISe6dW3O0pYbCAPp
 ysyy8UY5TeUuZ07LW1SpSUDBCfUcjLQsrHLd1a0/30Q1DdE5gIgf3gePHHEibqG5Fpn5
 5lu7yVGSpvTZNDeiwN+FwVYBF0AJaeVSdBeB0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790615594; x=1791220394;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=bCQrhpx093RxQ2Gwdj2M9JX2qUvfI4WWxI/ZkkyFOEo=;
 b=QXKaYdHSBmyDjVfeK7IBrcc7W9PiMUSC2blkrd2jpjciUC7RRHezRdzpJg4Jte/G10
 4Iyv4bRkn9rXQizxa8eDj1rSrJNi8/15PLutYWDICtdT7tK0aAwVNK6IMD4rkOij//uP
 ew5t7pWPgFMojKiZQe6eWxdXd7gtFo2cMrjGPRoPpVQsTZ4cq2PFbVyDrcFLcEhu77fF
 CoWoD2CTDXhy/ok+v94TrBrSpQGlPlGkzqsG4lOhZk8awDw/GEAEVxzkGkqciEjVnLzA
 ZgL5/DfWKxjXvaax9B00p93Iqm6dhUVjXIOUF22bAzCHtgVbegYI4WFdUdA1I23jyRnT
 X65Q==
X-Gm-Message-State: AFq9FYI/MPKzZGBVij2TftwS7w9D46SB0raRFfnQvav23NEilA+cOMGB
 +/22Qrgs89/cCu7BA5No4EzMtVv29+V+wOTMSW6juU8993S2wR0DZStYkpfhRIgu+J7vWxRoNUV
 QA3SdZ+9gLXmzpzuO/8QMdyaCtnukFA6hsEZLYjrE
X-Gm-Gg: AYBFou1SOQrELfmnkSwvb1is0VF/QXwWEJZEP1Kc3Fg6m96vM3dLDFXlgy+7MeZSR4a
 OxTRUnlm1Cm96653dzYGWy5zSOb+8Ws0kOv1V6Qd88Gu7PDJfAxcP+rXQpZVrdFAWXRkDLWzKul
 dZnMl9IyKi49kdRVQX9EGeGUUZyAPe9v5Du5O1+JNj1TE4vEu7zaUnXKcUXqFTC3Wn7T74g1eqB
 wFDIn9N7n2pG/4M+jpBmw+dALwyMs83XMtiRwMccsyU3zI81bHcARbmMfucg3sYDRn3aHcksxzX
 93JB06LEAziCAkxpKMNSCFZeuBUAO0WbuT6gbITr5RMBmcXylvoBWw==
X-Received: by 2002:a17:902:d985:b0:2df:5c13:b37c with SMTP id
 d9443c01a7336-2e2c4990f21mr87395ad.26.1790615593552; Mon, 28 Sep 2026
 10:13:13 -0700 (PDT)
MIME-Version: 1.0
References: <20260903-ccaione-upstream-ebbr-v3-0-016658d0b6ba@baylibre.com>
In-Reply-To: <20260903-ccaione-upstream-ebbr-v3-0-016658d0b6ba@baylibre.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 28 Sep 2026 11:12:49 -0600
X-Gm-Features: AclHuK9Fos8Kpea4W5j4aNz-8s9wUWv42OLJUc6ct4MgyrA6BIGso29TYuVaySM
Message-ID: <CAFLszTjK6R_mp8vOZ_48SZzec-rVBRkSXBR2p5M2o5bBa_345w@mail.gmail.com>
Subject: Re: [v3,
 0/5] firmware-owned devicetree for EBBR / SystemReady DeviceTree
To: ccaione@baylibre.com
Cc: u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
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

Hi Carlo,

On 2026-09-03T13:09:47, Carlo Caione <ccaione@baylibre.com> wrote:

> before pushing v4 to address Ilias comments do you have anything for me
> to fix on your side?

Thanks for the ping. The design looks good and the patch split is
sensible. A few series-level things here, with per-patch comments to
follow.

> Patch 5 adds sandbox coverage.

The tests only exercise firmware_fdt_load() and firmware_fdt_stage()
directly, so patches 3 and 4 have no coverage. Since the fail-closed
policy lives in those two patches, it needs a test. The existing
bootflow_efi test in test/boot/bootflow.c could be extended (or a
sibling added) which creates the source node at runtime, as the new
tests already do, then checks that 'bootflow list' or 'bootflow info'
reports the FIT filename and that a corrupt FIT stops the bootflow
rather than falling back to the ESP devicetree. Something similar for
the boot-manager path would be good too: since the bootmeth_efi_mgr
path calls efi_bootmgr_run(EFI_FDT_USE_INTERNAL), a test could
configure the source, run the efi_mgr bootmeth (or 'bootefi bootmgr')
and check the installed configuration table, plus a fail-closed case
which checks for EFI_DEVICE_ERROR.

> Both the EFI bootmeth and EFI boot manager use the same staging helper.

Just to check, the plain 'bootefi <addr>' path (without a devicetree
argument) still installs the control devicetree and never consults the
firmware source, so the fail-closed guarantee only holds for the
bootmeth and boot-manager paths. Is that intended? If so it is worth
saying in the documentation, since someone reading the secure-boot
section would probably assume it applies to every EFI launch path.

> The loader does not depend on standard boot. EFI is its first consumer,
> but the source drivers, FIT handling and staging interface are generic.

Given that, doc/develop/uefi/ seems an odd home for the documentation,
since nothing in the loader is EFI-specific. Perhaps the generic parts
(uclass, FIT contract, selectors, caching) could go under doc/develop/
with just the EFI-consumer section staying in the UEFI docs? Also, the
test is built under CONFIG_UT_BOOTSTD and uses BOOTSTD_TEST even
though the loader is independent of bootstd. Neither is a big deal,
but the placement does not match the description. What do you think?

Regards,
Simon
