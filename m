Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F0E3CA5FEC
	for <u-boot@archiver.kernel.org>; Sat,  3 Oct 2026 13:04:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5B484813CF;
	Sat,  3 Oct 2026 13:04:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rluiWyTWRa8Q; Sat,  3 Oct 2026 13:04:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org AFB7B813B6
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791032692;
	b=sAlhglw1+xU87yBgLuT2kMayfGa7Wkv+5DdiZ0kt8k7AhEOIPOX6mr2V+qUnLFf5LCAX
	 vW7b1cB8CHWc3vk2jHMC12r0EPrg1gtTY5DUextzJgnkdjqT+vnDA9mKqQFj7UqneMHwr
	 YzkftloO4JLxvayfOudTBl9a2TudZTQv7XDEoHPBDVNNf2uN1Pl4IVz0fkYp4MxpVnw+D
	 tJQ/+LBpXlJYy3xYVkL2K7JvAClf2HbRiYpZqF2EVPEghMaym0bQCMgg2imOtxNE59HV8
	 NUAj+aADFq7vwf0NMVusMLbZGUNlEQrkm8Oy7dk1ZbNmcSDxh3dKI7E652/hsuCHygA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791032692;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=XY+HPgCap61wXJnfM3quNs6gpcRJmiYfn63cT1EWExg=;
	b=YHn6WPlWfyjMxAwXAh203V2nNYPi4EwOG7mr4Xicbm51KrekUYhulEg6jnUbCFS7BKHP
	 tC5Oj03NTizL1CiNtIYTNizesugARmrvNFJrD/r+ZHKJLP3jMZBVg6n1uQHsaht+/42ux
	 G41ZUHEGV3RGrKXx9HaZlpOnlHRk9NXGOfXlGIbVnBQA/pyfgab9cmWqIgrc5Y/VtbEhz
	 Xas5EDZ4CCs+Ml/XrtdyQoUl/np8CN7cQKddzrQwiS9gh8AFyT2qoRhaIZOJN+4UljL7/
	 OAeDiobTNT0K9lxSoyBMhJzhEkhXlahWIp92+zrUpT1X+AYDEP4k7yVm4UBU1d/s4vw==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791032692;
	bh=XY+HPgCap61wXJnfM3quNs6gpcRJmiYfn63cT1EWExg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=i+5y28JkwyKI2XiDsYwdT6XoEriqCG9xGuABgRAAllsnmZXssWyhN/qoJddh2fnXb
	 pv+pUlQje51thwy1IFcVt00B4Ck5OFcnAHra/pL07P9Bi6ZZ+2oXZIQQnfJLvHMzja
	 cqEx1LgSTTX7DMB/tPlUyaf230zJ8Jw4po93mDYMbsXZUddobpF8mRMcwwxSLV+tge
	 JyaMwxNvUsFQVemAENH+fJPnZ9LhT0kYXRgTBqb7kC1Whs2WatCDLrEgOvHz299IGp
	 b+NQEKqkQsVglXjssu+MFFBprWZzl77ZfL7r4vJ5PBkFJry4cYRdHazpZMp4Pr3BLR
	 WgQEAdiN4jhyw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id AFB7B813B6;
	Sat,  3 Oct 2026 13:04:52 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 91763179
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 13:04:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 83CC86067E
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 13:04:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7CkosIbGa6EF for <u-boot@lists.u-boot-project.org>;
 Sat,  3 Oct 2026 13:04:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 9534D6064B
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::532"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791032691;
 b=svDqdS5Ccua3t/HpnfbGuKUkm/HZ543hEJDqJd24fE1E9cRoyk5Mz79gm4nDGr1tYkdf
 8Lu9v7OeV90v0/D3WL+pWToPcnLFXRTKJ6MlVI8iGhN2y9qRqlugKDYzYsXxjPWTSn7vj
 y20SmiCOdNBOY1irvv2BZ+qnD+82voHGC93brOOelA4jdf1mumgMJpfvObGk31nlY5DKD
 uNmAo2nGEN83RKNhRyYkuAEX1RdUzhxLxrgnTqiK0djTh9x1e7KpiLINOMi2mpMS+qYr0
 XJeCiQaklaDEm+veumkv0wDgngRRnSkd5Nwa4jrg6ulz+lUMoM/0i8V4BvzjEznyZIA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791032691;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=XY+HPgCap61wXJnfM3quNs6gpcRJmiYfn63cT1EWExg=;
 b=BvTNR+z6FNL7KFLBNDgVQz4/kM91jxDgsNBcwsXv3Wv6G/NDDrscLnIzUVWG9g5uB5AE
 7ezYbJP+SPH5yTduof9MiAo5/g3mp0VJRfzGnmir6MSwqO8neEJZLNGosIg4Xx3Jfrvz1
 Bwm6enL0V3VDw9Gl769UIUnwZE5q+ljH4IxWerBuQY04bif4mM75fIc69tblMXRUQ3fhS
 ma4z0mMZa3GqPUMUzJHz8nHe3awqq5CXpVPtfzcvISwpN14qjEr9N8kqKuFmR7dxBsau2
 aF7fTmTAUE2OXZ7tkfx5Oy+hLduqVSJmHKfB/rPf8PQ47Ikkk2hU7j8C/3OBdCgNRTA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=chromium.org; 
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=hy4n4FBp; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::532"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::532; helo=mail-ed1-x532.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=hy4n4FBp
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9534D6064B
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 13:04:48 +0000 (UTC)
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-6acb9c018ffso409005a12.1
 for <u-boot@lists.u-boot-project.org>; Sat, 03 Oct 2026 06:04:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791032686; cv=none;
 d=google.com; s=arc-20260327;
 b=QJpLaxtxZUL6BH/1iDNcfzhyiTaMVk/yvcRTe4s9ePY0c7INGWIgX/nT9QcQ7FEVya
 KODaB7qLKXgsL4hGCai9wWIQUHyy1Si0tke27TaViQg+kdlz8iinXqqIurJpH25O03kx
 eKVJ02BOMqU0oit7LpA/MF/yr0gXTL+4yewpkokXe2f1RK9oyi09GPlrzDJdf/QTWBwr
 SWxwwVI2V82lrYuOxfowsA8/8LSDiL6qA2ILr5LlW7xq3vF3kwZtEvs3Xt7x9OrC1IfF
 I31dBCYBOJ01E9aSVyTHRqUXNF22+003MWCBozRCLYW7ywxFUAESuYm8GLmeZ7HGdtrK
 PUuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=XY+HPgCap61wXJnfM3quNs6gpcRJmiYfn63cT1EWExg=;
 fh=BEoPNN0ojtgxNz8fjZSoyMObtb+XDDU+qZjnWDTAHBk=;
 b=LUEuAfg4A2Yk9WsG0qS4qCI0EHNhy3uFxZ538AadA2fnkOQbNjz+lStiCHAttLF7Mj
 d+Wx2RBHA820OdtJM7oTEzysIvSAxbNmm6tVYEu20zUShbkXQ9ZMLkI9AZtDXacTocPJ
 pOMT6zsHznFmvQecVOmBDTy8JdcJ+zS33YMdLiF71P1rtE57YNZaT1F4J6El0c9+xX+j
 lOVFBmuJa4Ipjm+0aEKzZximjOIumXOsRgomZdqRUujafme5qvgGa74zFOIMNIAlRlD5
 DWip/PJ19e5Tyafkrzc+fifeBOR2H7qyBQOnb0Of3yPSUoTWue5jFzwp7PSwZQM5s/yi
 8aYQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1791032686; x=1791637486;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=XY+HPgCap61wXJnfM3quNs6gpcRJmiYfn63cT1EWExg=;
 b=hy4n4FBpZmOGjK5TBG/V+ZZuAC25K2lGISsPTfKpaF3ARXzbquA/XkpUMKTaVs9Zmu
 5sGw3veZYe3XMg1L6j5U7aPNT51UaxOqIAC8tnrLIF7WYD6NcAbnJV1c++DMzgcYvDXP
 34XnJnNLDvlMN1NzeNJv/nixi8N9Y51ZUoNto=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791032686; x=1791637486;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=XY+HPgCap61wXJnfM3quNs6gpcRJmiYfn63cT1EWExg=;
 b=db1cYP2QDpcBQu6BFYQ7jVi6b2NQ6wrQTz/X2CAn7k5GpVvV+y4uaSzUHdmHZdAgce
 f5B3qYt0J8FjhLcdu3HelI1zB6KRX92VoZQG+XK3aHPbaahH8NR6D3X9RYfwI5aOZAA5
 vdxO34AoKyVRszNCxjd7xL/26oKQA1GQP9GD8+Q6v7XM5KOffi2F3+SFcxRzeOVbSIBt
 FdNgFlh1ZHF9n/j7O6FdmxzsR/zwX9j0ZcbrFVCrfEDP8+JVcAlFOK+H2YjbDBi4mskX
 7Pd3tYYptwP8au2c9yoE0FjuVNh3jGhr5ADSeU7Bw+6B0Jz2wtjG2Vr7i1ZbRzJicUOB
 oGcw==
X-Gm-Message-State: AFq9FYLDHMoAIRZuGT7VhLDFenLoFGUvfpJ1p1coV8SgNwcMbPIGHfe3
 pMrEiFcxXo7J0uxNK4bCVglP9AVlP9/FW9VhCbg0jNUnXnwzlbABpk5CWUXdjlZDcywgm44HD+s
 60MbcnYM4mHuC1kNv5/azO6WsOwDdaCfaLRj66ILJ
X-Gm-Gg: AYBFou2lbBQzafHzcKIKC6zDWyScOk+Ayc7gZiR2coJMf+Hgvdr8QPpT2VdzkgUKcDt
 +SaUiRKqB66EdiD1dnYe6piV2033oOZx7omC22W8tIVaW3p6+QwODB9dIgtKLhYUCEGWe86q6YS
 D1HUlQXqKi4aa2czp/hgP50J0gc3lJt6Yj5BRuVgEhsiqE7DdMSmUFhZmJFzN9YuxN8f3+5XGop
 akWMiOjekcfLEvLqLB4ZzyDDp4u+gYAZyEDixWlrACrjCX1IsxuRPMaH7Vkfkpwrkw8GvNXN7h8
 /Ib7u38hLAJBd6wJmZMx4hJ/n+vU+N1AX4be2SOvkn1ljDcNB5CaH2UtsMex2R16CIA8
X-Received: by 2002:a05:6402:3448:b0:6ab:18d:553e with SMTP id
 4fb4d7f45d1cf-6ae307fc2aamr5486819a12.7.1791032686321; Sat, 03 Oct 2026
 06:04:46 -0700 (PDT)
MIME-Version: 1.0
References: <20260918-ufs-spl-boot-wlu-v2-0-8a63e372bb6e@flipper.net>
 <20260918-ufs-spl-boot-wlu-v2-6-8a63e372bb6e@flipper.net>
In-Reply-To: <20260918-ufs-spl-boot-wlu-v2-6-8a63e372bb6e@flipper.net>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 3 Oct 2026 14:04:28 +0100
X-Gm-Features: AclHuK9bd8n1DuvPmekq_3yPMZFBpDyzyaYMQr4Y-oiF9AWbyRso84T1Zg8n3sw
Message-ID: <CAFLszTgyDOqsLBwjX_uH9PHNNgAfsrZDxYmCJ=P=mpY+kHyp_Q@mail.gmail.com>
Subject: Re: [PATCH v2 06/10] part: name the well known logical unit device
 type
To: alchark@flipper.net
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, David Lechner <dlechner@baylibre.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Julien Stephan <jstephan@baylibre.com>, 
 Simon Glass <sjg@chromium.org>, Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Richard Genoud <richard.genoud@bootlin.com>, 
 Casey Connolly <casey.connolly@linaro.org>, Johan Jonker <jbx6244@gmail.com>, 
 Denis Mukhin <dmukhin@ford.com>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>
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

On 2026-09-18T06:35:41, Alexey Charkov <alchark@flipper.net> wrote:
> part: name the well known logical unit device type
>
> A UFS boot W-LU answers INQUIRY with peripheral device type 0x1e.
>
> Add a pretty-print string for it so that it shows up meaningfully in the
> device listing.
>
> Signed-off-by: Alexey Charkov <alchark@flipper.net>
>
> disk/part.c    | 3 +++
>  include/part.h | 1 +
>  2 files changed, 4 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
