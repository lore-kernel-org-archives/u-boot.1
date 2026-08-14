Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F498C5B572
	for <u-boot@archiver.kernel.org>; Fri, 14 Aug 2026 22:37:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A1A3540C59;
	Fri, 14 Aug 2026 22:37:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 61Q5h79o6Wbn; Fri, 14 Aug 2026 22:37:12 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D698140C48
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786747032;
	bh=9bRKu7Gq3BflAkPGbjFikrmpZU3r5EHAndnLFnOfwcc=;
	h=Date:To:From:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hcEs1XAK1NvYAQzMPgrWZDZXeTAqGm/yejo7MjF7OtDkr2LugosY6KERW+tb+mMys
	 mDoHjpAup9zpCq+ow2r9MW+YiOJbYS2BKLU7X30UoziQmWXetveAX8TNnjtcMJCnxC
	 nDPkWCJITmxhC2mxhRlp9RoGm4Vj3sV+zYteqLpzuqrrcb3+UJqPfjoV2d74RmRwIc
	 KzjRBYFMhLQUhDWc3Nv4hVHlzAKv3WNbMg6MR4r3RtUnMOlHsv13H1hSt1q0TUxpHJ
	 9PHB/eB0dVzwkInDnU8m3rgMoqQETuoGciOg6BQMumQt03sdjJal2dEQkiiJfusQCi
	 NCU9rsZ4FI6eg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D698140C48;
	Fri, 14 Aug 2026 22:37:11 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 2630B3A0
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 22:37:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 17B0B40C48
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 22:37:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Y2kov99Sfkva for <u-boot@lists.u-boot-project.org>;
 Fri, 14 Aug 2026 22:37:09 +0000 (UTC)
X-Greylist: delayed 74391 seconds by postgrey-1.37 at util1.osuosl.org;
 Fri, 14 Aug 2026 22:37:08 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 84D6140C47
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=proton.me
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 84D6140C47
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256
 header.s=protonmail header.b=gxH01b9O
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.70.43.16;
 helo=mail-4316.protonmail.ch; envelope-from=munzzyy1@proton.me;
 receiver=<UNKNOWN> 
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 84D6140C47
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 22:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
 s=protonmail; t=1786747026; x=1787006226;
 bh=9bRKu7Gq3BflAkPGbjFikrmpZU3r5EHAndnLFnOfwcc=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=gxH01b9OpEaR4Jdt6qCBuv6+BJw1aMKt+ymD9t+RmP1CIzA8icg92zDiWNywhknVB
 kZM7ogs+AzMHd9hQ0Nk4ppPzxfjHXWYE0uJwhdbCt/ONY79yn7uXZkswydc2hVJddB
 ZUtUP9A/scjptLkIiWNuHFyrgsu66MnV2D7HLBoVQ5HVs0FHVLWa+TP+MG/b3IZSqK
 KUFb/EWvHg5dzi/rupio32paTRDkh6/GWUcHPLyaPbb38HOAziFcWR1Spc48xWqoHV
 VtJk1En9cO4q+lYM8EIhjZDYZoDwNwkYhCRkKv/YzLB9kGFIjrU448AjhVGZPkumdC
 XjhezM0ApD8OQ==
Date: Fri, 14 Aug 2026 22:37:00 +0000
To: Tom Rini <trini@konsulko.com>
From: Cole Munz <Munzzyy1@proton.me>
Cc: u-boot@lists.u-boot-project.org, Alexey Charkov <alchark@flipper.net>
Subject: Re: [PATCH] lib: zstd: update to latest Linux zstd 1.5.7
Message-ID: <08526dc4-5e28-4ecb-950d-e9ced9de721f@proton.me>
In-Reply-To: <20260814210646.GL3297518@bill-the-cat>
References: <69502f5a39ab3f07b7872cc6dcbf7e86f7e7d42f.1786670589.git.Munzzyy1@proton.me>
 <dd01c4b5-ed45-4fc7-8670-026aa38ee284@proton.me>
 <20260814185328.GK3297518@bill-the-cat>
 <259e9abc-603d-4a07-bd6f-41b357abef49@proton.me>
 <20260814210646.GL3297518@bill-the-cat>
Feedback-ID: 209578162:user:proton
X-Pm-Message-ID: fb4e53d4fa84a90cf3c94ddd84492dbb62ce9dd4
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Thanks, buildman -B localises it well, and there is an easy win in it.

Almost all the growth is the new Huffman fast-decode path in 1.5.7. turris_=
mox
and mvebu_espressobin-88f3720 give identical breakdowns, text +1896 rodata =
+24:

  HUF_decompress4X1_usingDTable_internal                 -    1508   +1508
  HUF_readDTableX1_wksp                                  8    1312   +1304
  HUF_decompress4X1_usingDTable_internal_fast_c_loop     -    1092   +1092
  FSE_decompress_wksp_bmi2                               4     316    +312

Upstream guards that path with HUF_DISABLE_FAST_DECODE. Adding it to the
CONFIG_ZSTD_LIB_MINIFY flags in lib/zstd/Makefile, beside the
HUF_FORCE_DECOMPRESS_X1 and DYNAMIC_BMI2=3D0 already there, takes turris_mo=
x from
+1920 to +236 bytes against 1.5.2. Sandbox ut lib still passes 133 tests wi=
th 0
failures, including both zstd cases.

Trading decode speed for size is what MINIFY is for, so it looks like it
belongs there rather than on by default.

Want that as a separate patch on top? I did not fold it in because it chang=
es
behaviour for existing MINIFY users, not just the library version.

