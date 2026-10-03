Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8ABFCA5FEC
	for <u-boot@archiver.kernel.org>; Sat,  3 Oct 2026 13:27:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1A208414A2;
	Sat,  3 Oct 2026 13:27:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XOpnv7bY_Qoj; Sat,  3 Oct 2026 13:27:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 08D9F4148B
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791034023;
	b=aVFgs0Hny5ByMfG78w2ct3qhcGi25/yWlV4pKZeqpoIN/Rl8Hw6lo19rI1c+H95aZatY
	 WOEHVbvA+KlMKPKyBS+v8oQ7/+Qtae9mP1/Y9+4eU6BzYMoAUAM4M3Lk0hWXAyTBVzlV5
	 0dVze5I08YT62UkMOUP5TjHeZHOUPjn+qkrU4Tj8bo7tPLAYOxmTVhzJ2kuehVqTDXea6
	 JHrAeUVzYSe2mTcEUkr4oC1NRco+3iQgODe5/Hy9CXBuFTjSYeOWB8EkIhna/7apvUQJq
	 uuGcWwk+m4VO8ks316TDsE9p1Ie7BwPEGUdk4I+Gbj06Ie9E9CFCrx0UD8cQPikybuw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791034023;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=rIIvaBTea7fHrnNALtsJPW7z9RbczfnAi3w1CB8kb9w=;
	b=pAXGCPAKL9GOpa+6qnZyo2DRF1mOhJ9shnimwtZtpNC9rvVkLf/4Et91q5DXngde1Apk
	 kz3OmiIwZk02U7uEoDq66Jvfwp+hxB1ftRM/7vDunQ56N+G783LBxapkml1vVh4HUI24m
	 oLp7rXwgkSyctjlKEQEuNtB1sSkx4unnm6u2nsRuKJAOi6OPvB5G67P044183OEiMi4oo
	 qgGNdiW0pnLvCOUjpRDfDTJEPBUvQh0PvoTTKOjXROxLxu+7xIPYpyE8HXvEFNe30ZIKt
	 JRY+jkuY73IdPRDKa5g+/2/gQxokqORUJe/4SkWLsaoYVAC5KLVx19n4yl6J1WKBZ8w==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791034023;
	bh=rIIvaBTea7fHrnNALtsJPW7z9RbczfnAi3w1CB8kb9w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=P0oYyzTFMB58+pxsTTh4OALWMChQZpSLEtslsmzxSYSmLKUE4khmZeMFmOfHQLS9g
	 WW4QoYdyE7h+fFAMw8GnVog7c8E69s1ShPJ23O2OFBMDha4t5Et09dMGcXKLDayw/O
	 +jCYOq/ID8Vcz/VvZvpjFiMVMD6pVGOFBa4OFu83n+LKP7ZHGpqxLKIydVEuFVe9hw
	 5i/pYkejEnqDCOetuiVCAkzUf+sUsK+xDwt0F/dutJ8bKnAWZ+kRYcHPFOcrcUp1aE
	 0Zl4ozDU/7Ef48cltupIQWn9FUQXnUNK8fOrS4/RsRvk2IIojB+f017+7DKNJGqObT
	 lK/ZTLrmDxjMA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 08D9F4148B;
	Sat,  3 Oct 2026 13:27:03 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id ECB88335
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 13:27:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id EA02A81372
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 13:27:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id N9bhpy_BcYxc for <u-boot@lists.u-boot-project.org>;
 Sat,  3 Oct 2026 13:27:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org A12BD813FB
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:33::c"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791034020;
 b=dNQD6Ne0qiTh4drBzqjTzvBMpFGLgCtwr8BPjGp7JQambZujW6ClDLM2WJy6WpZFMK3f
 rIBahN3ch+9MR+s/55mC3NvLMyf1ct5vg0y/m5/YbcnOOSVSd9WGoIgTTCvJAbeFwaCoS
 vXxMb2uqiTVDmAiNIVrg6+Klr1vPsHD16++wE+5nst41UxEKRHaY2vB3kS6fgV5d0dmvy
 gGZ5ONsFWPVkCEL8L5w0zF4xlLEZc6e/fBHjFz4d62FLiyY0+R+feYM6GDZHfBZqXlME/
 nkpQBLo97vGSmWQAK+5e7Ln/nQ3wIYwruh9TU2ZgGsbKkIH1z09oefv51sXGaGVFiOw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791034020;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=rIIvaBTea7fHrnNALtsJPW7z9RbczfnAi3w1CB8kb9w=;
 b=PFZJChCdpq1Y3Tisf28xt5n4ms98XaCn/YP8E6WEWFfPDZbwZwxcEDW3fNPlx3DBLebU
 5LxYuOFaItzetbBztpdvAc9khqcQlfTZyU6oU9BJpfwGuxS1bJcQ2ayN+Kk0PsPHkZfUn
 ZNePvGl4XtANs4017DJGij8b5SwYfcNCOPH5OXNKBEQ935EuICcTtUW+bhXncdZERf3U3
 5IeqmtbIzfrh+R5Ug28dMuYSGwr6/pbOy258RLrgxV2aBU3szf5Y5Nm0DNXYuNH9ZfnKZ
 sf2XJDa2GQudNGDZR+Rl13683ruTn3dRgm/trbkfIEUWeDha4t/46kUcxXfqlJoogpA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=chromium.org; 
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=FpwiD02s; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:33::c"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:33::c;
 helo=mail-ed2-x0c.google.com; envelope-from=sjg@chromium.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=FpwiD02s
Received: from mail-ed2-x0c.google.com (mail-ed2-x0c.google.com
 [IPv6:2a00:1450:4864:33::c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A12BD813FB
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 13:26:58 +0000 (UTC)
Received: by mail-ed2-x0c.google.com with SMTP id
 4fb4d7f45d1cf-6acb8b78d6cso512778a12.2
 for <u-boot@lists.u-boot-project.org>; Sat, 03 Oct 2026 06:26:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791034016; cv=none;
 d=google.com; s=arc-20260327;
 b=dB/VTafmCeFGyeHQDdgKBtj51qtIC42joxkCXT0VXD4eDiSYcC732fH2rs1EE01iuC
 VFLqntOOgoG5EbmVl+93axh3F1RlSpkuFkU0YmYZa80ZZ3E1QVhQt4nfTAyy9mxA2B2z
 KElBnMoFNrL/LgnBbCShoPPhNiKPZ2KoCEB2XF92ZtPWYPRr+Q4/2tiw1yUGHrSGD7na
 ztNdn60gqKQp31xCbynKBWB/GX3bjlObZBx3wTpS8Ik3L4J+Skez5LdjDr8pAw9DsUvM
 nkngqURUIRYUz85EmC/9PjHVJQZxdpk4ALN546DJBiji1iAS6FnT/bySMN3E53okmmUp
 yz6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=rIIvaBTea7fHrnNALtsJPW7z9RbczfnAi3w1CB8kb9w=;
 fh=WqZGyrgIigfLSJmABemSYfRdCBpJ8D5RVhvmw8gTcc0=;
 b=MJ2nHHC/hwm70xDKm7jUSjzhLdHPMplbCGb3v2tSfyy8seETQy9MIkAxuN1dSj86Fi
 RxqP4cOBAFebce5W8iffbccww/S4/Ye2uKpG6hI4CXy8mezBGz8eaHO0s1d+wlUryQ6C
 0XTqgXe/e7Zg6+bLjnOGNvzYQ1lYdG+QX4zDb0cnTcF13Utt4KgOxuMDhQ72zjxjoRSz
 dVQY0WW3VFijr9+xTNhIFzuoC1wjOlT3K61o8I3aPP+VQCf/9HXb29p7mf+cJuPG+3h6
 YWp02PEyZAjBAjcLcH0FlZ92l8MmjpzFPVWDxQC+TC1qkfkjcbJIutL0w1rBJbKfylRs
 Q+UA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1791034016; x=1791638816;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=rIIvaBTea7fHrnNALtsJPW7z9RbczfnAi3w1CB8kb9w=;
 b=FpwiD02s7FhcGtussX7K8/rK/5/F6PtFJNrT/0YqvAfluoGVuwhlaE5UgF0CCXUsb9
 ztPoPgvjSXYb785o/anik/N2ktBO+XQlXpwZVw7lIT7VCZRDTkVtpbZ1TCF77WzffToA
 kjXgNOi7RhIR1vN1qRia+pN0xsyD4tfPhzS90=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791034016; x=1791638816;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=rIIvaBTea7fHrnNALtsJPW7z9RbczfnAi3w1CB8kb9w=;
 b=F/xR+MyaXgQnDHhjx/ij4oLH2+ahtlMIW1jZWtnmDET3xb22hB0fmAkPE0MnmXxB3c
 PCjwYE2BKhuuUghtj5YNH+Ok23gC+02Au8xxeHnOA9yc5nDeCS5OrZcDNu4TQ6YxymRc
 oqQXiaHaHa2QTM7/DLLWQg8AoWtwwFzvVe1msj9zMy3POcOaXv5zhnxUSktjBXmMP6YZ
 9h4utxBIhZATO94+SQRX/ckyFQALGYBFL99XAy8zzOr/DGAeOXuMtfBYn6E9Sxekj1sR
 vNWQZJMxfmJjuSi2OnHG1lAiSK3SqWdDHMdyIIJ0zm1JoAEIAY1a1+U8+MlhhCahOP/X
 6Mvg==
X-Gm-Message-State: AFq9FYJKd5f8GhtVzqUBsI+Bj/03dn4vrYyu6EoQo06Keo/GdORNBP1Y
 hjw3wls25V4E/uq5kr2flTlv5Z4MD1kOEJp0VRgpURZ0TBi5GmG03sVduLZFtoV7nAQmQRogdxQ
 CJc8WLpurAN8wpXbSgPKqkH+gzT76amCr//bzEdbm
X-Gm-Gg: AYBFou3tnL86e0iAz+eCrjMquY/6PM7E7VTlPJkZWTe6bTFSqI2wCIpc72YNqrdG6dN
 QD9so0v9Ajj/owzOU3uEIqqocHzz1ztEkRnPgPJyihQWRXlc9BYERvDlShlh8MQnDKdKjNBujuE
 sdRXkOQ0JOp0KMQO/SM8lKCeRFex9osbRJ46g/yqqS7Q1XO+cESlgjPAz0FAspKQ0+I+gxZfjUJ
 R9E8zKs9sewm6CA1c9bilSbc6vMilwa7l1q8hec+MfXLCZlH+mjTpVOqwckVWg7Two3uj2wWUmp
 y3uzsDvdyZhRnUnAlI3RcOGepbPfWYWYG8X0g7zyQbxuJz27V3rpttg=
X-Received: by 2002:a05:6402:1950:b0:6af:82a0:d3b2 with SMTP id
 4fb4d7f45d1cf-6af9e2f9281mr4468586a12.29.1791034016206; Sat, 03 Oct 2026
 06:26:56 -0700 (PDT)
MIME-Version: 1.0
References: <20261002073357.382228-1-aristo.chen@canonical.com>
 <20261002073357.382228-3-aristo.chen@canonical.com>
In-Reply-To: <20261002073357.382228-3-aristo.chen@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 3 Oct 2026 14:25:41 +0100
X-Gm-Features: AclHuK-fCizamoOqemjpMU026TN87xdtPR_cIT0I7k_NsZjhjy8o5lQ3pw0Ct0k
Message-ID: <CAFLszTjG94kEphRUgVWS1Dn2BwS0FU12TqUN2VKX6R-oCOZgtA@mail.gmail.com>
Subject: Re: [PATCH v1 2/6] scsi: drop the duplicate COMPARE and SEND
 DIAGNOSTIC opcodes
To: aristo.chen@canonical.com
Cc: u-boot@lists.u-boot-project.org, trini@konsulko.com, 
 David Lechner <dlechner@baylibre.com>
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

On 2026-10-02T07:31:50, Aristo Chen <aristo.chen@canonical.com> wrote:
> scsi: drop the duplicate COMPARE and SEND DIAGNOSTIC opcodes
>
> SCSI_COMPARE and SCSI_SEND_DIAG are defined in the table of commands
> for all device types and again in the table of commands unique to
> direct access devices. SCSI-2 (table 31) lists both as commands for all
> device types, so drop the copies from the second table.
>
> The two SCSI_SEND_DIAG copies also disagreed on the command type: the
> first said optional, the second mandatory. SCSI-2 names SEND DIAGNOSTIC
> as one of the four commands every target implements, together with
> INQUIRY, REQUEST SENSE and TEST UNIT READY, so the remaining comment now
> says mandatory, as the other three do.
>
> No functional change.
>
> Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
>
> include/scsi.h | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
