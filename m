Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DAFECA9EC5
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 13:57:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 468E380D5B;
	Mon, 12 Oct 2026 13:57:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4kNhjBvyzK52; Mon, 12 Oct 2026 13:57:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8137980C67
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791813464;
	b=TIQJzM6zr/vQYQXsXZm6ceK8zi6rF1T4B+tUqf0KfwafFmTXM/bZpxDu7NCL2/mOjVLv
	 LztJwwTfUvsnEoe9fIoU/DxqS07YBCGiA70eLHsZRpOscuNeIRYLHzl6zpZQWtgsYOIfJ
	 x+xp8y8uEdN+yEmxnTfVRV+qEzA/eEbT2FZX4oV2VByduAJChXf9EoIit9KF7FaHBmvOv
	 o1cxH6zz122S7b//fgpvF3SDO7gBJ94LlEKDmdDKMeShiiD6T0oWRTKU4JKuo6aNXw/PZ
	 +KIxQSNjrdGp50mt8wwKDxC6dlTIyV6BqcBjN99dma3kA889J8DGGLN/pIKuxtDZlOQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791813464;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Vnd/cjv4EbyC4BtYUaHktyBSWSCS5xg20aZL+wzG0hc=;
	b=RUlUPicgbeFqIH8U188af3yY0wili+PI793+nJZauy+3x9N3RizyHwhADh4pXbhq5DiV
	 2JR7zbhR6eKGUK1683C4KHFMfcTzWYEMhPgltOVwNKnbvr3MOTM22T7U5AVoi/xZyteyC
	 PjQTzXG2Obn22g0vetbXo9BWxOndXYbQj1b61ClfrNJyrqkzbb/4EAcYn773KHqQjLIj3
	 5e1b+Q8X+1U8MncgLMgCsw5J2UBgKZXPtikDLAjHqlqXetuoD5y7hoMRqNZb85HzkWVSF
	 Gmy+6FSK3DliF5cnJVmFe1josLcmPspqPS1NKMcGBsB6/5Vo2vnNwYjphMh5wq3sQXw==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791813464;
	bh=Vnd/cjv4EbyC4BtYUaHktyBSWSCS5xg20aZL+wzG0hc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oPEKapSALLZWqCcw9AQVmIjIITjz1TQ3Kww9zzOd1a/CS3igojNxa0eEGPwhVQ2i4
	 /jYE9+0w8XFaNGQc2HKGEbR2m1w70Snvh18nhw4pjhs6mwZABoOatAcbAhn/nJiq23
	 9NOZdfDIXjsEPNyKOHJT/L5cKw9Ts82cn2wNIFhSgJSCDIrXFISkLrV35YM8oVX2A8
	 4En0QiXVTyZRm1gklMu4T8YOLCUjSi27GjzDL2Dv37ttScxpEa7ixS4oefty06dmWO
	 sUHEvrLq4gvwhP6D6W5yTEICXM7QFgo8m+iTXNWKvFIUzYEMjzwOvI+XieDHW6xbJh
	 H0mrtR76hd6tg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8137980C67;
	Mon, 12 Oct 2026 13:57:44 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 14EBE9DF
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 13:57:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EC2684010F
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 13:57:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ESi8xcFJ-WDj for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 13:57:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 0AAA94004D
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::531"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791813462;
 b=S1Uz1PNjq1voRHiNFNY/Z28rTShFNHs6Di+BBVVgP545Vwj88IHfTNyQUpRTVyQHt48q
 PmbY2R1gAsIvije9IvhOKFS5fr9m5uWM0PiZignKt0Gch8WzEMgPnWZFGcFGhxJwydCR6
 M+91/VdaRqy+V5ZKFCeUVzPaiC5t+1zqVbpXIe1gjKVe1+ZgzvUKSiwuI++oAroFY++NF
 ug5SUIRmZt6mtRhKCDJ61EMmXDCUSSU1Ek4BBcVgjNKxqpUrzWBGXwNi7oUm2Tj/2bXSx
 sOYz7kLXgwOBLF99s/XT2QFPjka4A/weblsFmoTrgbQMctcT8AVYpmRJCyNj9/M2BTQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791813462;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=Vnd/cjv4EbyC4BtYUaHktyBSWSCS5xg20aZL+wzG0hc=;
 b=j5+DDka8xsU1WPQAKw0XBw8bD6MTnlHpEfyf4eKW38FU/mTT4nRSoGZdx4OKeB0oQ/eX
 MbZbKGLQFD+gbIMdNImLP05WqquFox8uRWskNlVtOvE5zR4ehSp1gxwWQC7q5HTc2z8OW
 bv957hCjfyc+H/uiYpP/dBqXJQs5/Lo0MLX9B8XqoIqT1+J3fhYAhn14BwoXWN3MIpsmc
 wMsxUwpe+jHG4xeynEW+Mote0NsYLrPEL43v3yxd3k7LnG7F/Ke1xlbOLpI1MBu2vOt6g
 p6tPSGe/Mjs8uh30K7XOOH8ztJUGGeMaMvArThz1N8fQL9gn7ypEINuirQo+aK6cjXw==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b="dmFMR+/b"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::531"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::531; helo=mail-ed1-x531.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=dmFMR+/b
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0AAA94004D
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 13:57:41 +0000 (UTC)
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-6aa8d04fcddso4058928a12.0
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 06:57:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791813460; cv=none;
 d=google.com; s=arc-20260327;
 b=kGhytqNdjv/a0RYXoFS/LnNn/OzCimjBLCJug3Uva3WWoDInLjXAk15u+e6wBVQK07
 jT/VaLJ0AwshF/SpKWdKg1GJzNhbLIQt1IF9dg7DWzYC5Wp17ztY2lzDDEs31uZo22q4
 iWND7CiRtrUOpK29KR2kKEMwVq9p4sHs/++KMDlb/HrDo/61VMs9E8/GealwnqYSlO/b
 ykZHg7PqMOGoyFhunNcqd4AjWBCI3I2QlevckE5fc9dEmK8Ni6jI67fRCdpZJGqiB7t3
 VNm6N4QpOQ5lPtD4nDHKhqehHx96eiT0HvWAHizSS80dEUjwA1kTsQdPg5rMtxsbcf2S
 Fg1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Vnd/cjv4EbyC4BtYUaHktyBSWSCS5xg20aZL+wzG0hc=;
 fh=8kLy8Cchkv6HU01zDgapzB4SRbyqUfaRhLrjroAK5g4=;
 b=jmNEejpJeLQy4tvnXhMCmoKxaXepgMjfzYJ8tw7eQl/qtAg89sLT4Ybcrxs3+nUrz9
 KPHFfVvxOrOhEkfVaAK7YcAnVCmrm7dUV44WRYtOUjx13WYN/qsAAqxqNXtmLQOkeFJU
 OVVpYMHdMEECwLaKI9P0WrHMdlwNTp+ttrNC1JIFQxPFeTBsvfzn/3pkIBV++GG3cWpU
 ds7T5oHIZhc7RZfRSEt01cuSCp82MK3sWSKzyG5pNF3H/RLdwWwYVTALOGtsPiTw7Jk6
 qr+rzEdv5+RUv8xxhV3ZO5Bs4UaYOpWu+Z1Jl26XUHveAyFgQpmr8s8e/njx/M2No5QT
 U0sQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1791813460; x=1792418260;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Vnd/cjv4EbyC4BtYUaHktyBSWSCS5xg20aZL+wzG0hc=;
 b=dmFMR+/buJO+4f4nR7JJ1dMcMphgqRfkLYOfZFGc6NdxWEyrEx+oEyNnkG4nGsKPos
 sfIb+it9QjVWZxvQ+9lrE/xaK/Kgs4Q6l12uDUQEycVFGcMuJKmKrBqnW92NyfSKJ47f
 03tb4zw23tEZXSxJme2kBufmhsFWAu9w3lkm0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791813460; x=1792418260;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Vnd/cjv4EbyC4BtYUaHktyBSWSCS5xg20aZL+wzG0hc=;
 b=C5ElOuP0AEZ3y9HmaqQCy4rGvQ1GTOO5vojqTEplq1jwWkeaEKTCKNH2I7xArFgzwN
 k8BwqK7jWeAY1gV5D/dcoD53o7YcA9J80+kbezVT5v0/ujWkwjumH3FmIFsYEBQ7+NKc
 eoBTvJaz3jYgcAFosJbUosCsfpDnPIctKkDgRlux5Rv5b0vtprf2faeA4BYYFwpMUyEj
 OcV/yohTMDHoNb7gw6HSnntrL+DtvOZUYMiEb3XewPfXCX+jQPj82XjbGBZC2HL4xbU0
 GBJR7BbDCzJuu+nBz0c1U4Jbf87l0TgOda7+DIXvuAd3q7mRmXEJwPFdtWhFjkbUgWaw
 qfpA==
X-Gm-Message-State: AFq9FYIePIRanuKcDV5SXeFKb0hmW2PW0hxqse/Dd5MjUFdM4TqxoE84
 RyhUpd0Gjck13OeRXncGqp+MnjBsGLWjYncn/ocet+c4KX6omsUuKk1yymujddvFWcqCUldjwsJ
 Il0eUFmHehjfQkHB9xWOgoVY92YDUu5PyHk+XjWcA
X-Gm-Gg: AYBFou1Iw+wuBMBxuSGJGa698Q0zvgrrQRxIeiJ7YMihT6Hx0aQ5jAd0gJWMxPh9Q32
 EVtCIt0zL3PdDKil+WkwWiMj3J/j7lkJr5o1FeETVOsfOjALjPAOHV/m3SBx2hBoDFUEjKuoKD7
 XKwrTRmnR/xYumyiTvx5ny7zsRw22qrPCyPgTGX/WERKwYiO5DbO4IE4Ai1AbVTqH0N7TuwoDzO
 JHkfUa2gpPaCAN7L8pP0Kir5EnTYu6znJzZVEDoBteZJOS73KAQ3sbRAyAcOc3T2CImevz9x8oe
 Q+v/HtqboFZxtIOVX9Mt6oOLQEvxklCqasktRazV7HpdFLj6J7nHbUA=
X-Received: by 2002:a05:6402:5c8:b0:6ac:62aa:e3bc with SMTP id
 4fb4d7f45d1cf-6b17c2942a5mr8010583a12.9.1791813459722; Mon, 12 Oct 2026
 06:57:39 -0700 (PDT)
MIME-Version: 1.0
References: <20261010-b4-binman-fit-fdt-compression-v1-0-4465558758cc@protonmail.com>
 <20261010-b4-binman-fit-fdt-compression-v1-3-4465558758cc@protonmail.com>
In-Reply-To: <20261010-b4-binman-fit-fdt-compression-v1-3-4465558758cc@protonmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 12 Oct 2026 14:57:21 +0100
X-Gm-Features: AclHuK9KMbXQXg-9QVITj83fHmVhKGWHAAT0JruQuhZ93WhPrqtalcTkWY0ttAY
Message-ID: <CAFLszThHiga4BW4zWU3Tcd_D5B132nU87bz3EvNXf=a7AuZT4g@mail.gmail.com>
Subject: Re: [PATCH 3/4] binman: test: Check compression of generated fit fdt
 images
To: petr.hodina@protonmail.com
Cc: u-boot@lists.u-boot-project.org, Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Marek Vasut <marex@nabladev.com>, 
 Wojciech Dubowik <Wojciech.Dubowik@mt.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Petr Pavlata <petr@acrux.cz>,
 David Heidelberg <david@ixit.cz>
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

Hi Petr,

On 2026-10-10T14:24:46, Petr Hodina via B4 Relay
<devnull+petr.hodina.protonmail.com@kernel.org> wrote:
> binman: test: Check compression of generated fit fdt images
>
> Add testFitFdtCompressed, which builds a FIT with lzma-compressed fdt
> images and checks that each embedded image.

Please finish this sentenc and also mention testFitFdtBadCompression,
since this patch adds two tests?

>
> Signed-off-by: Petr Hodina <petr.hodina@protonmail.com>
>
> tools/binman/ftest.py | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)

> diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
> @@ -4357,6 +4357,35 @@ class TestFunctional(unittest.TestCase):
> +        entry_args = {'of-list': 'test-fdt1 test-fdt2',
> +                      'default-dt': 'test-fdt2'}
> +        extra_indirs = [os.path.join(self._indir, TEST_FDT_SUBDIR)]
> +        data = self._DoReadFileDtb('fit/fdt_lzma.dts', entry_args=entry_args,
> +                                   extra_indirs=extra_indirs)[0]
> +        fit_data = data[len(U_BOOT_DATA):-len(U_BOOT_NODTB_DATA)]
> +        dtb = fdt.Fdt.FromData(fit_data)
> +        dtb.Scan()
> +        for seq, expected in ((1, TEST_FDT1_DATA), (2, TEST_FDT2_DATA)):
> +            fnode = dtb.GetNode('/images/fdt-%d' % seq)
> +            self.assertEqual('lzma', fnode.props['compression'].value)
> +            comp = fnode.props['data'].bytes
> +            self.assertNotEqual(expected, comp)
> +            self.assertEqual(expected, bintool.decompress(comp))

Most of this duplicates the setup in CheckFitFdt(), which already
takes a dts argument. You could add an optional decomp argument (e.g.
the bintool) to CheckFitFdt() and have _CheckFdt() run the data
through it before comparing. The compressed case would then also get
the existing checks for the description, the hash subnode and the
configurations, which this test currently skips. What do you think?

Regards,
Simon
