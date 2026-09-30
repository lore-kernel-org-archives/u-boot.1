Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DEEBCA5FC4
	for <u-boot@archiver.kernel.org>; Wed, 30 Sep 2026 20:15:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EFBB340B45;
	Wed, 30 Sep 2026 20:15:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xeGRj2iE50iR; Wed, 30 Sep 2026 20:15:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 3C82840B30
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790799321;
	b=QQ3S2lLxPjgQoe16b4rz3Ypw9y1krshKK4pKaPPWm4TFwOSleHV/VEYIC5qkY8NkxUmT
	 leYCQCMcEsh0tvNMHSpoTsPRfyrvYYPpw7mV3MeTFp2jbM7SwvQg1yedD5IQSYtX4U37h
	 Mb52IypV30OvXk/XCvoGyLZgeuMNI1uj/+SkItTb5MRqSe2oNHiJEO7xz3U2YmtZrqxS9
	 2hzkvjUnfVmOR17lolDOzqPr6lvE254YUpMXR61uTbmqfNFahq3UBDXc9zNifFIv7JDy5
	 M2nZvUe+QRxIr5apenVA3nMYfO0DOQhWdGVNXFZdjyWbReiwxzcU9CfFpoRl0lHcMVg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790799321;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=YulL2pGcVGyrZb5ZsIEiVrJrZRlLCZ7IM0GMtba3h90=;
	b=a00E3cWfcDOoY/34U43zfBI7ve+CRQ/U427bK7bpYJ2vvVCKHFq6okYc1hAzbPovkfGu
	 4FOOLusR8ulYHlcL1kEfasKx4famf0IcDIL+u0eGC7OCTOLy6JkEXSiRHioCb3exAy//E
	 TRiNvxxv1FA2pkLhv8IF7bRqIlwJss4plLYRlHYnRaAYQXQ+GoFo3d3SEpVzP+DoQdC1i
	 ZwB5CkbHHDtojSRJmBxNxXMilXGTqzAUKyATIuXwGxM/Y+eAmydevW7Gv44aLcfWbdmLI
	 cePWOyM0kkuxbLt8TU9hE7XnG3/8nTQ/QecC8b66oP5+r1c2qdVn4H7yjXQ/8anwRbg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=aJl+lLHt;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790799321;
	bh=YulL2pGcVGyrZb5ZsIEiVrJrZRlLCZ7IM0GMtba3h90=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YEncmL4d12OU0NLddnf6jofi5jFNWEfUUM5l7pl5fe2DTexMJQOYI9z5iASkvK39M
	 gfJKEchZIG786qTN+m8Ow9K0PXztW8ABCteHodUYC9MU01AkAUD43oNnjTNTjTsRaL
	 ngEDG5E9RpBOg4X0AVOKogxTjxl+guEjzzWLI1QeVgzDeYvopemAgbGZUheyZzmuUj
	 mDRcAndYBy62ZJG/TdPF4YzlsUbWBOgNEjVUP+sXiJIxkp9gjJsOaYxvBCb1cA0D4R
	 5i96cHm16g3WohgXteJ44Kz4ZDaB+n59/ksSJjiiJNhiedkp7MDI0Loy4W6BkJiN7q
	 PuhmynhmJQ+cg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3C82840B30;
	Wed, 30 Sep 2026 20:15:21 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id A4F3524E
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 20:15:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8A72F40B2C
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 20:15:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id t5lf6ztj1wvh for <u-boot@lists.u-boot-project.org>;
 Wed, 30 Sep 2026 20:15:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org B59E540B26
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::2b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790799313;
 b=hA0kRTw5cOxrVgDsqxH0U19ZZE0Sq5PFSNUZ9DXbAzIO915F4sSVQeD1L8D2r2dBvGdu
 ktH1umgedrmEOjGA/bnNYwKZRM3DsJ0lSvCp8HfNZu1wbM7WBJnsxZp+xOIMz/wC7fSNM
 FKA9Qhfn/IXBQnjjVxNCyeP9zvbHBg9gK0ynhVJ+cgaG7wB0fQVOvfXmMTl4OXD6ms32R
 S7gafoJr4rkthY5oDQ94l+QyBpk9PU67MkC315ZqtJIfjMAqsUF+hgiOVtdKsiDSssBbS
 vRBv/pkGynNazoIFIwEzAQhep3jvVASRXDUFcJ6kMacZXyzc+yeQfWXzwFhqL03hvSQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790799313;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer;
 bh=YulL2pGcVGyrZb5ZsIEiVrJrZRlLCZ7IM0GMtba3h90=;
 b=dVP1k7Ba+dEvAv5YIE4iY0GW3hN8bGNksoPz8qxYVxCWU9rY3Yukjdy73wUd1Ce8H83o
 vRIzQqHxOTZQndnDOXG6Lw8uNYd1ktIzGWAFB9oeL7aAJAA8cdRvIesO+mbmjebmTLGQ9
 DD6rHtkbAK0r6p/vLyfMF5/qC8DpgGfonKd30JTWOZgjpylMMtj4z/emgFrbzFZ3vxq3J
 krM7Og++jYTC8HidZPIwX6uZIPSWK5HwNL2ldlApJ1VUhCIkierQyc1mcalfg2wsNW5gO
 z8JzSuzoOS48/WGOamnIjs3OK7jOk1ZkIr68lOYJbm9g3NZg0prYRiGUEiFmXifVeRQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=aJl+lLHt; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::2b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:31::2b; helo=mail-oo2-x2b.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=aJl+lLHt
Received: from mail-oo2-x2b.google.com (mail-oo2-x2b.google.com
 [IPv6:2607:f8b0:4864:31::2b])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B59E540B26
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 20:15:12 +0000 (UTC)
Received: by mail-oo2-x2b.google.com with SMTP id
 46e09a7af769-81d10e0cc02so1485767a34.0
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 13:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1790799311; x=1791404111;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YulL2pGcVGyrZb5ZsIEiVrJrZRlLCZ7IM0GMtba3h90=;
 b=aJl+lLHtDgoDaET18dgCtX9wFxVOh+I5SRo1eJQ+SIPPoFfm8Vc5me+G/Qef1VgWlA
 BaMBm6ZnOtbbNs1nWxy4/r68az/kSH2G43eUIef8WmvUckXxWQOFDqLL2LtlKoC2pvUd
 8AzdOq1m26RA5b5jKhEUbkskW4jjh5skATDQM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790799311; x=1791404111;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=YulL2pGcVGyrZb5ZsIEiVrJrZRlLCZ7IM0GMtba3h90=;
 b=XNYbY19FcaW3/k/EhS0eh39UuGclarNVRE8fOphiuxcy2NYTMx7+5k+UDKLzTLpwMv
 9wxpTzExDK6vab1uccV/lPWekk8FJiyUrs91DArw3h8K+YXt/NYuMSLe0rKyNjZ3snZT
 PA74mqTbNdiNVrcAmEvNiVvwyXy5ibAxB89A7bZ0m1+B8Ngzix7ghVoe89sZqjDTJn3/
 a93PE8yakdw1SplCHELqbZa3NazVW+U7UPf5xZhfI42mq7RsqAwfd4NeVRJ6F8Eg86QR
 EBJRt2qysMuyEU9t1ML4AnRrwEjcGaxYcE0NrseEOd1uAXxK7JDsckWq/5hlFDykjjya
 GYfw==
X-Gm-Message-State: AFuF++mlbWEcEL6vzM0wGGa9HGruzABpeVKrpEvTRdGE6foZFuWDY8sb
 65BQ76h0AT0swzjlHEfqdoooSkaPSHjGhBS/dpyebxmCZst9q1iKLQb5Fedrz9szsZE=
X-Gm-Gg: AYBFou3eL9GzBWF59wtgatH+tZGljYi3eWMEJhDmIF/ke0eqquc0rcSN110R9YyJMW+
 nXgp5mzZq+WQN50Yz8O2cyvo/8VNbIVOl4X6CLtdtBPft0CHjUfSySbL57/38gP+OmS2RajqD2M
 jTw/MQqZMFpAdKSEsN9JufDdJgKY6QtGuJPlO8qlo98UWLi+JkK7HBoamCQQoAimP/Vlih56e+L
 tXiFX2VdEybLRlx/V+FQCwt5kq8RCI3/u9zw3dYkzlYSwcV8fwyFq1JtmEtWU/2T3Ns5SGO791W
 L3g0Cz6j90YtlcJ3jXoBB0Nn7sHijxlD2/CiJmOF50po7CAqJdPx09ng1o+C+CtrolKtU7nNca6
 SZ/NV3o7jLiHJ1WGiE3EwIvhNesl1XjVT4+cPXrePZoBBqht5BiAxCgPFQ5bumyh9nKoWlBIeO1
 n8Lo49l7Rd+30J6VnW4J9Jsu80T/ftGk2DvYSMMbqpoA/vYSXTVXha4KKH0mlD9Bo37buNwep9o
 pl8NdI65b4hsJ3bMXQRCgCgLUk5O9Z9+tFTWyNR1/O3LaXsRKNWZ9k2NCj8U1aVlT/xIFiv/4/b
 BAwjg9lQYuHMmbdjOg==
X-Received: by 2002:a05:6820:f028:b0:6cd:3fdb:fa6f with SMTP id
 006d021491bc7-6dcf6e16e87mr2160606eaf.90.1790799311151; 
 Wed, 30 Sep 2026 13:15:11 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-821281a797dsm821896a34.3.2026.09.30.13.15.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 13:15:10 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, Pengpeng Hou <hppiscas@163.com>
Cc: Mario Six <mario.six@gdsys.cc>, Rasmus Villemoes <ravi@prevas.dk>, 
 Max Merchel <Max.Merchel@ew.tq-group.com>
In-Reply-To: <20260906044916.27956-1-hppiscas@163.com>
References: <20260906044916.27956-1-hppiscas@163.com>
Subject: Re: [PATCH] mpc83xx: Fix MPC8360 system PLL dependencies
Message-Id: <179079931039.506059.3130925767524015560.b4-ty@konsulko.com>
Date: Wed, 30 Sep 2026 14:15:10 -0600
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

On Sun, 06 Sep 2026 12:49:16 +0800, Pengpeng Hou wrote:

> The HRCW Kconfig migration misspelled ARCH_MPC8360 as ARCH_MPV8360 in
> the system PLL multiplication-factor dependencies.  Since the latter
> symbol does not exist, factors 7:1 through 15:1 are not available for
> MPC8360 and factor 16:1 is unreachable altogether.
> 
> Use the actual architecture symbol so these choices can provide the
> SYSTEM_PLL_FACTOR value used to assemble the hardware reset
> configuration word.
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] mpc83xx: Fix MPC8360 system PLL dependencies
      commit: a2d66e6a938ca0cdaaea12fd7fee9181fab219ff
-- 
Tom


