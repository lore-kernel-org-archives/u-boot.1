Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17938CA5FC1
	for <u-boot@archiver.kernel.org>; Sat,  3 Oct 2026 05:36:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 35AD881227;
	Sat,  3 Oct 2026 05:36:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5d30fjykoNgg; Sat,  3 Oct 2026 05:36:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 4357281206
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791005767;
	b=lZ2OSvbAXKmGS24E6UYxh8Edtd0rXH5ylxqWME/jSskQz6uqM0dEQaNGIEBXFhGnzjyB
	 PQYGlcYhdg/N9u/lOykUms5HKEQABPCZEmTJawa4S1r4rgm0GEncsAUqSrbxI3vG7mQ1H
	 1a6zwlTJ9vBls6XeS/dQaaVsekwsrssLHUIKbIU6xnoN2Pn1OQgKjXa9aqK4iZTY10DSt
	 qv24oxt75v50RuDi4Ib1vKPXQL3WpYFfOPvTQMwBTCOY44Q6k6WPUxDM9Q6PTJj+dwLXU
	 kDXmwd0aVPF2wnRv1jwca4+QzJS9mhfukawprvUGHpYwOkZh+iOILUZSeD3l37UTfPQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791005767;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=ghxRnGcb8JnbSJqPrmLc+0pTl5xotgyAZPQn8zdFvW4=;
	b=NJGTG40wrgi4e5yfjqwnc/EXOXJlp3wbNHJu8eJAmmeOVWgrpOwHYHvpf5GorAtGq8qt
	 /XQqvCJfalyd1a4SgDqUL8YM+0rQWU2GqjYCW/O3lK22yJW0rjlQzjyxy2s4lqw2h7s1E
	 KRrXqX6C81fmHG04oi9DmJ4dMg/Q0hl53Cf+EdsxOJyADMLj+M7zm3CQ5lsvwuRNOB5Ea
	 Yv/qeFuYeH6S++SBhPwmKsqKvhW9r3wmAOwRtoAmZBTxWmk37/+YVIm+aMvHMtnngpFPV
	 JTpCjkGa43654BWmuaudKw0fWxDwdMB5dpqr8mX4B0Beq2UdBR1xkRnn4ltJMPVj8MQ==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791005767;
	bh=ghxRnGcb8JnbSJqPrmLc+0pTl5xotgyAZPQn8zdFvW4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PKPlySQs+zio/fHdN3exaA5PM+C5Yp6VN8L70Wf2jJZ/7C4a5Gz2qGXA9UbkXbUwk
	 39HavuyN9Th9vz4mc/r3nRg2KMx/ov3GUk/VY0n9BSbJbBDKkkuUs/Takv9rzqr7L0
	 /kixH9gaLVwe1Pk/6nXlX+V5On5soA5ZRzRbbt4DV0C2ftMJc63gbJ2otszipvVfC1
	 VhQqDt3wRVX2b66veF7IK91mj66kTKcqHQ2VSt+Gf472NMDVQzQ2c8TZQan9US8uc2
	 6kinKyuPBbmoLQY+EQRsCaiF6UhyyZBFiFMTu7wIZFpnrzg4kPLlWxkMMm1lLCscAi
	 Ow6AKL+vtFvyw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4357281206;
	Sat,  3 Oct 2026 05:36:07 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 039D632F
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 05:36:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DD88040BC0
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 05:36:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RUCZnjLIR9qV for <u-boot@lists.u-boot-project.org>;
 Sat,  3 Oct 2026 05:36:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org E1CC140BAC
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:33::10"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791005764;
 b=mwwVwI6TE3A1/yjY4aJ6ORLMrXLzbLq0QOpLgfXKNsQe0U3N2VhMvAjUIMCdkrQDQznX
 lNI1Iwa9I5FfZDQaE7iVHWE1WbfEgBf3vJltur9gl1wRnHsUdp1xLBlqdjE4wElUlVtXc
 zarKGKCfaeT5bNNg+ExMenHBQM+ZOZz01xPtSHHtVkE2gU8P4Tonye7OUiiii2+J/qwXH
 zkmPzka2lvlkjx/RMV71TCTvJlB1jbXCC62Ac9Jmsjq/6tT9SjZ5OAeW1ei4ZFHZ5nxTD
 8Qcsw8WRSrFd5Sz6klHinCVSlNzvtaEqqw5Er8E1lcpbQW+AS0XWJD6eMNoVsNp8Nuw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791005764;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=ghxRnGcb8JnbSJqPrmLc+0pTl5xotgyAZPQn8zdFvW4=;
 b=kSuB1rbkNnaVQm1icQFCLdKCeSkgqit7T/WSQSpK/LQSE6jXJdyn1vx7ORUH8QotpY1q
 xmQxb53JZ0eYGOAqD06bTM+RxQ3Sset1+5Q2Ftx5AEVsd1MXTqNJSLHuH5rV1iKDfysOY
 HRhZkwW3yQSAF6j3j/ODPqSa5efX0J7F4cC87FkuAjSQwkT8K/tqwh+sSLmGKYVuoyLVZ
 iGg9+dN74N0b9bTtmEcSuPlA1CNx9vPs52pEjLJYSIl0eO+xX4zwSsl+vjrYHKegK987D
 vTQDPg5evR98ZKsbnRTF6bwYbQ50RDs93mukRz5EBGUiBL1eyp1ODqEws/nkWviU0xw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=chromium.org; 
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=V1KidKqT; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:33::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:33::10; helo=mail-ed2-x10.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=V1KidKqT
Received: from mail-ed2-x10.google.com (mail-ed2-x10.google.com
 [IPv6:2a00:1450:4864:33::10])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E1CC140BAC
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 05:36:02 +0000 (UTC)
Received: by mail-ed2-x10.google.com with SMTP id
 4fb4d7f45d1cf-6a9984f9adcso266421a12.0
 for <u-boot@lists.u-boot-project.org>; Fri, 02 Oct 2026 22:36:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791005760; cv=none;
 d=google.com; s=arc-20260327;
 b=JrWdNZMZWIAMSNXnPrIuEA8sX5qZGtxCNf0vBGitrSv2jj/lxTa1/HdDCleRl0ASL7
 uoEAWfXgzmca0LX8ape3bWBgkSFwmSFSpJwOlyXpYLqAj5Ela9VeY5rIRMGmOCnKSrKq
 4xU/gurDAiByikv0JbRf+t7MdtpjUmnpxOkiAXS6rKfcgYyMYiDjYYUr8NI7OXtOuMih
 MWqSov+b0C4N4gcxv61L/ozBPl/NWsLXLkswnEcxemImmcFnDWhDX+UP0J+A2w8q3SKY
 vXlJIZFZWkUcEacRKkKq2ng6+Y0ngrK1aysDUVIpp2ra7hec6CwBZtCFmr/2TAtjS4ES
 LmVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ghxRnGcb8JnbSJqPrmLc+0pTl5xotgyAZPQn8zdFvW4=;
 fh=evWIV3D6h7odC9/QOEM91Pyk1dtYD+/r9WuSex3j9co=;
 b=UdZK82dPkAlw8YYs5lD1SmLdb2VUwMpwMH4sF7s4Sgqpeb1bgB9nnxsKDt4kOx/3w5
 tp56hdDjHqGKjkVGlbRqVtuXFlO2uB8cdJcFeFoG+GcbfBEY0q/tZOJOae9jy9aKFMvM
 DHICElBMu3F4TyMLVuG6CcLEYwanCkbd2ey0mKwhRT+NiQjlwQs888+2N1uS1Hyx4zi8
 vBfnfRdJnsGZ3LbHbQ4IXK9wzoRCGkfJBjgXEVCGZfBX/7zowa2W1cI0XX1u/VOXqCRE
 ApwWbQbwT2SLscfXIawEkEN5Mgk+YGUddLR8FjjVeqzYNLNaUqVnKPV48Z8axwOPIdDe
 3GfA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1791005760; x=1791610560;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ghxRnGcb8JnbSJqPrmLc+0pTl5xotgyAZPQn8zdFvW4=;
 b=V1KidKqTq+nnAegyr44ixfOzxaWVuHUWf6iH3lAl+cNZC33SmJnSyBpndGDQt58unx
 1Vow1ZN5FVi5wxcSLAEz2vDLSI35AURf3nL+22ptX9tz7tDqi/NzMidM0bybIwoE4I0t
 D+/jHunxNIwT9Zg/KBfjqy5f2oBStdub+N/G4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791005760; x=1791610560;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ghxRnGcb8JnbSJqPrmLc+0pTl5xotgyAZPQn8zdFvW4=;
 b=U6rQb4SxuVLAsE3NvTWVHQIGdp1kuXaax9RoiOvCZi6iNPJ+hCVH4i4Lw+8W9pICn5
 A4+v/HjZfvAu5S6FddTS3XJRKzfG4zXwEXUjADruITs+eIdPgtq74GBCljITZ2otBG/i
 1WOLenVHixinVUl4ML0rLMJkwQpwOu0tAntoTWDkjy4hyHqlHgHFQhuVF9nogjBVBRs2
 lutKNJeSUfDhxITLy6uvyG0RrTkBRdTus1/U/tLPk5zU6SXyJK1sLse6BtvrbGWf1xbs
 dlt5apRpAVpl8m24xiapxItC7K4hUhCObnZS04cLoO3njwnQ4XpOPjLi9R32zob+t3iH
 A6+Q==
X-Gm-Message-State: AFq9FYI+nl+W9Qt8+Ld13Jvkig4j4KOCRWZCN+O10Cod0HKlH7MiuTJM
 7U79n58FfqFJA+l94rdYIWJuhHCQDB2vg/GXhlxXJ1ihfxy60hsP5WaF1C7yGixom3OVR/3Ud3E
 igcyyk0VsoIzcHUJLrozaBFHOoZUAD+29cZuZgVyu
X-Gm-Gg: AYBFou0DDwQwm9rFCTNP0C78xxhwUIOfQmr8Xh3f3krbL6xsH+zBc/ckNOE7BUWMdqe
 bBAtKYTTlXrp+RBqwpSCLiNugoBpxz1vXVX7lbMnWjKPsnvPWVB1+c+pNg5lYxc1XEXis8XCAW3
 onduiTzHGmTIbfd22iMXDkUmCAr05c+tn/VDoQiyZNMB29kU+TWH3ZyPqtsGQVU4goB+5KyVYjY
 2i60TyDk19q4ZOOS1clqVWtSaU4WjyU/tzcsaBiDGPJCpLNwggUf7+GQFCaYlK02kd+WDqZobAg
 z22Qc6CHFus8dPGZR1STD6ZFaItLfKuWBVWJgwYFp7cK6WhdktC+ar41
X-Received: by 2002:a05:6402:350d:b0:6a9:6944:57f2 with SMTP id
 4fb4d7f45d1cf-6af9e2f9fc1mr3683232a12.10.1791005760356; Fri, 02 Oct 2026
 22:36:00 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1790887323.git.lqing2013@gmail.com>
 <91ebffa79f9c5a6d3ab0d05d35fe5f113cfe3555.1790887323.git.lqing2013@gmail.com>
In-Reply-To: <91ebffa79f9c5a6d3ab0d05d35fe5f113cfe3555.1790887323.git.lqing2013@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 3 Oct 2026 06:35:47 +0100
X-Gm-Features: AclHuK-Nv12GuGNtbaMr3HBX-NMWk9TCHleLR3dascZ3mkG416hn9wUwra1CsEs
Message-ID: <CAFLszTg3mWzX=N477Ob+SkNwyXW_djPGr79xq9KiynUzm7=CDQ@mail.gmail.com>
Subject: Re: [PATCH 6/9] boot: image: skip FDT reservation replay after the
 fdt step
To: lqing2013@gmail.com
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>
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

Hi Qing,

On 2026-10-01T20:44:44, Qing Li <lqing2013@gmail.com> wrote:
> boot: image: skip FDT reservation replay after the fdt step
>
> boot_fdt_add_mem_rsv_regions() removes the ranges described by
> gd->fdt_blob (the U-Boot control device tree) before adding those of
> the new blob. It runs both in the BOOTM_STATE_FDT step and again from
> image_setup_linux() during BOOTM_STATE_OS_PREP.
>
> In a stepped boot (bootm fdt followed by bootm prep) the second call
> still sees gd->fdt_blob pointing at the control device tree, so it
> frees the control tree's ranges a second time. LMB tracks plain ranges,
> not their owner, so this also drops parts of the OS device tree's
> reservations before re-adding them; the re-add then fails with -EEXIST
> for the LMB_NOMAP regions. On Xiaomi crux this lost 128 KiB of the
> XBL/AOP reservation at 0x85f20000-0x85f3ffff.
>
> Only add the reservations when the separate FDT step has not run.

The free pass comes from 623f6c5b6ab7 ("boot: image-fdt: free old dtb
reservations"), so please can you add a Fixes: tag for it?

>
> Signed-off-by: Qing Li <lqing2013@gmail.com>
>
> boot/image-board.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)

> diff --git a/boot/image-board.c b/boot/image-board.c
> @@ -918,7 +918,14 @@ int image_setup_linux(struct bootm_headers *images)
> +     if (CONFIG_IS_ENABLED(OF_LIBFDT) &&
> +         !(images->state & BOOTM_STATE_FDT))
>               boot_fdt_add_mem_rsv_regions(*of_flat_tree);

This skips the reservations, but boot_relocate_fdt() a few lines below
still runs a second time in the stepped case. The 'bootm fdt' step has
already relocated the tree and updated images->ft_addr and
images->ft_len, so the prep step allocates another block (with a
second CONFIG_SYS_FDT_PAD) and copies the tree again, and the first
allocation is never freed.

MIPS handles this in boot_reloc_fdt() in arch/mips/lib/bootm.c by
skipping both the reservations and the relocation when BOOTM_STATE_FDT
is set. I suspect the same makes sense here, e.g. work out the
condition once and use it for both calls. What do you think?

Please can you also add a test for this? Sandbox goes through
image_setup_linux() and test/py/tests/test_fit.py already uses 'bootm
prep', so a 'bootm fdt' followed by 'bootm prep' with a check of the
resulting LMB reservations should be enough to catch it.

Regards,
Simon
