Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADF76CA5FC7
	for <u-boot@archiver.kernel.org>; Wed, 30 Sep 2026 17:17:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5B07C60B69;
	Wed, 30 Sep 2026 17:17:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kRRIXMjRibmt; Wed, 30 Sep 2026 17:17:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 9DBD760B5A
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790788663;
	b=Aon8+mRpb8kN5ZwCXh8qmqsGXsMq8E3+wGYJlUlzwfVzFXCig4WdeERdZqEIkFNIqElS
	 Ny6mxCzlqpB2yXWlfEaD5wWrpgqQ5gK1K/OXEABkPCI1tUMfLA9HTCeFi8irgTZ+Q4ius
	 hbrdCCVRyqPPrudCSN+eQEin1EF3uB+Pa/NfYqL15pjvtYlb0DK1IEds25U213v/hxD+F
	 WtrEV+u1AK8pbvS3wH6ddWE9yjXgKihJESi/4wmInKzUHLnIHjU7k7Z9FjY/2p4JdtWIc
	 hGBz3i10veHo0MRV5uFxsL6u3zW5IxV2+0WzT35tUpOSrKHIuhkB2cn5InWZIU24Syw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790788663;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=aMyFXVTS3B3FdHLlm3QXKHo24W7TIXeJf+9kqZuSjAY=;
	b=J+r7Of0jjxDbwucLKSeGxMQYSbYMdr+12PaR/3/htJojkYBkDWDqNrx24kE4l7ZJBn29
	 +fAPveDg/EC/uCVEjO2sf8tsGt2oDqseglzDNoKGbOPU2iwnTh1owBw0ouCR90Zrc6FxT
	 bMIsTfjWMfd6sdqcHKDqeV9x8es7UjG9BP59jHcgbaCi8rbIkKDVSHu0SvJPNC+WpYAQE
	 mCxlVTn+AdtaMcgg2ox627dnpISjpMXuVcJX613hLW6dThbSLPt+lCtfjDqJH4M80kw+U
	 0knpdUVw37iNrGsO73bLo087xu5JkuWFSaVsophRSNUztjtT9zZ3J7/FwEUgb6OSiMg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790788663;
	bh=aMyFXVTS3B3FdHLlm3QXKHo24W7TIXeJf+9kqZuSjAY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LNxl8s9DhOoavHTgfsVnV8b8IZvG9TBjSdRKp7sD17oZijWUZVeb1M1hcQVS/kPKU
	 rlMqMb7h21rAcPUEwNjGZbT2MOcCvn+Ba/LaKEynHNYcXbbkS+AwMXDxVxO94HQkgv
	 mO8+G7Tr1PbvMs3yQLzFCXk/bFVKRUX+Scgsr6j1s8bu11t74t9BjBtY4euWDixYQ2
	 09A76BG7nuLnLc0vyYV/NICOaHqG1+Cf32FFU/TS4kJbzNVvgKtWpP1IYJKQfRh1P8
	 8WxqdXjOE17PM1rCCfSQ/8m+ClUKs62ToDPqj4w4E9h0Scjcg69GAwXbZgHTJZZSJG
	 KW+ybgHsheAJg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9DBD760B5A;
	Wed, 30 Sep 2026 17:17:43 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 186E134E
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 17:17:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id F2A2C40382
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 17:17:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ml5NFi0S2IBP for <u-boot@lists.u-boot-project.org>;
 Wed, 30 Sep 2026 17:17:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 57F7C4009F
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::2b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790788656;
 b=eMEZY4u0+eW3Bxx7GVMVC/s89beIWYVEGhVYhFhUzAMYIISFSGhpB1QPec8eUx8Jhmbj
 9UBjjV4WcnYJRY07EiiEDYtVST1Z96uON2/tuSknwgUID0pNITQFtmqFttv/NVJZ7r0z0
 2wOy5JoOLefgE/vFOMgDJcn6vDECoLbyPHNG/dd/aJFMrCBt7Td4zPBS9p+2bppPd5rJd
 zur+x0W3P0XnuZlwpFYQGYBb4WX3poYiCGsaC4WcyPxvnF7ZKI1WQ54pxrn0Pm4ZXbCuY
 ipJ3s7Vza6s6nY3zlV7o740EbIQdRbLafCYrGhOajpX3fFM2GrBuJixymUl+BHzwJiw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790788656;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer;
 bh=aMyFXVTS3B3FdHLlm3QXKHo24W7TIXeJf+9kqZuSjAY=;
 b=ocAULyu9CPD/6W9JKai8HyOO5BLXq3ZFLKVdeWgceUjbFmpDx80ZTppxRHIMvnlK3kBv
 pKh2/+Sfo6JNTw3snb9SvoLkzjnyolBTPntQYWF8ndPyvQhIV92pfRw4oxisLD1U/l62l
 7vgxbxRvHRpwqo/FIYxJruvB4DoC9yUwkvM173kZ0lGGQ4k4EY8e0ZqpENe08fzRqnA1E
 HOki6UIvQcBjQEjv9TJIKqWZsM5L++nWl0jzQJpOV/rBl22VAWHpe/o0emCW3P0OsjXlA
 HoNqfuWRuhHuoFPCEvybNe5Oco7Q4wP9Tybdb5MFdIlc/DuvIiPh1hEeYajRs47H/bg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=s+VjMkKS; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::2b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:31::2b; helo=mail-oo2-x2b.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=s+VjMkKS
Received: from mail-oo2-x2b.google.com (mail-oo2-x2b.google.com
 [IPv6:2607:f8b0:4864:31::2b])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 57F7C4009F
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 17:17:36 +0000 (UTC)
Received: by mail-oo2-x2b.google.com with SMTP id
 46e09a7af769-8144632e066so3085110a34.0
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 10:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1790788655; x=1791393455;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=aMyFXVTS3B3FdHLlm3QXKHo24W7TIXeJf+9kqZuSjAY=;
 b=s+VjMkKSXior1obSYh3A/pIymxagnenb8hK0HNBWT8SDJ9DCzreBePtbQ2Cs/u1gWZ
 +Bwuwg2KmCF5ThrTXq0QEJRilFV3qsDrjLgNc18/ic8NwffcjpEOnlO9cE016H/xznAY
 XHrULJhKT9qroBF7qtdYjI7SRvW9hogjZ+5Pc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790788655; x=1791393455;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=aMyFXVTS3B3FdHLlm3QXKHo24W7TIXeJf+9kqZuSjAY=;
 b=QGuOZRiLSJiZqmOVDz634RxEzmnBeKWWmBdXyQRxRTDlF7YK9Qj5dzxXJrQhuz6uW1
 W8gRKDgRnzn9IL6kqd36MpcMXTpBxN/CNiVECw5Va46bz1nB1n2EJkiY9CV6hjcuY2QD
 6dtQuU7DEWMcgyHYCmvEBNiCQSiXhR/0mtWe1BhY7T40HVRfcNZxyfYJyGFriW1ABDDu
 56l6OILhMof/sij3j8B3ts3xrnbi5h89ZpnCikRNe/emUL3tXPj02GkmFqQRV9eKuJ1D
 H1zsoTel0EStSYjtYhA4gxUKjao2iq6C1erLr5Q9rCSZukoIlfZstuEJeuzEZ6csD7J/
 Yulg==
X-Gm-Message-State: AFuF++loUBHtV8ihaAb4RjSTkmWDzmAidrDvSc5V34eCLJUanV9YmWAG
 uvJDttCUUV2xwt5nus0cQUY6jru+w0qIAnUQU+BIaoFs6fvNifQYhsCeoNZ2S+yHRDo=
X-Gm-Gg: AYBFou3CvaTOGwrcoCDuG9Xk47sss+C7H8wTdwKkkSjQqinyfmYqs8LjIuzEeEwt/jD
 +x/l7tlEmYQ9dfP2bpdKVI4Rh0ZozNU/qbCLfoy+MCpSVcy/PpH1ntSGweUeYwQf3+exsOMgDV2
 Tb0z8sWjW6+jhp4Y492DP107NPxXpo22F0zE6DQ4uwQKUTa6SPS3K8L+GlihUCDW1y57IwrfRy7
 IJwBBz130k5mLy7QbgGovtmOSovuyiens05zSeruADLkm3Zhmad8kCiLg1miUGr23cwj56MtoNh
 YW9McaDwxHsICUiqj6jx5bNbgpPo5xtuostFSp3g5+maZv7HfUIZ94bjF+m+alnYmTEx2DBkZw0
 k8oi2KeRdLkE78QPhWJMXc8YkCoQkIj8DcEvkTuL7xt0VC45SIU6GbHdaPq4AukE1O9HLPF+De9
 jedfVGqk+FYW01pZPD+a/mOh2/IXiMkikLVyCNEW1uAkbq8xu3H8jI+802jaTZSU+XSG2iHWcLS
 n2+8dKiNRg95ZBP8DRhObp43nUhl/lZVVyXhI0Evyzfnu4Cclag+Kz8khU8NSbt5OyRybhPJwvh
 IN05LOA8KOhzWniwAQ==
X-Received: by 2002:a05:6820:f00c:b0:6c4:5fed:753d with SMTP id
 006d021491bc7-6dcf5054581mr2041116eaf.45.1790788654903; 
 Wed, 30 Sep 2026 10:17:34 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6dd985dfee1sm591516eaf.12.2026.09.30.10.17.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 10:17:34 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, Adam Ford <aford173@gmail.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, 
 Huy Bui <huy.bui.pz@bp.renesas.com>, 
 Nguyen Tran <nguyen.tran.pz@bp.renesas.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
In-Reply-To: <20260913155253.84181-1-aford173@gmail.com>
References: <20260913155253.84181-1-aford173@gmail.com>
Subject: Re: [PATCH] board: beacon: Remove Beacon EmbeddedWorks RZ/G2 Dev
 Kit support
Message-Id: <179078865386.467656.9091674646926534530.b4-ty@konsulko.com>
Date: Wed, 30 Sep 2026 11:17:33 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Sun, 13 Sep 2026 10:52:53 -0500, Adam Ford wrote:

> Remove the Beacon EmbeddedWorks RZ/G2M/N/H SoM and Dev Kit board
> support along with its defconfig, config header, U-Boot device tree
> overlays, the leftover pre-OF_UPSTREAM DTSI files, the Kconfig target
> and the entry in the Renesas board documentation table.
> 
> 

Applied to u-boot/main, thanks!

[1/1] board: beacon: Remove Beacon EmbeddedWorks RZ/G2 Dev Kit support
      commit: 3f31d496ecaa6240f1e578cce389a06798d66c30
-- 
Tom


