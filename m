Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18B7ACA9EBB
	for <u-boot@archiver.kernel.org>; Fri,  9 Oct 2026 23:59:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6D273814AB;
	Fri,  9 Oct 2026 23:59:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id n0S9nAFNGPFu; Fri,  9 Oct 2026 23:59:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5F48B814B5
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791590392;
	b=j2VJIft9NJTNCyODT7+CUDguyc4jG86dLewBmHuKN8/N1+1egbkq4tyl2AcTgpPI7mJq
	 5GkW8e1iVd/WXPDBxBEhrIqIHJOz6oNp/7Ha0nU6J5c5a0OcC850BKXlOiHDTZBOdCPmc
	 bWv4JllRurr7kKucndABkrBFxMNvX+h45Bv8OI7txM4NgpKRIy0m1TsTB772JE4A+n3y4
	 okBpVPAcDreDreg4qD6VhQ/MA3GHjfdbCxZToP8t2iGUORfnekW0zQ2UFntQGHnDJbBwC
	 RkDYk4z/En7CccWeVuzjPizn9OQF8UxUyliTsdhG9c+xPS+/KOlQAfulb6nIsBCNQ9Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791590392;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=kU6Vj+xTfYp4S0bCQgXJlmqRSSxgnofN2Vzuuhirn/E=;
	b=MEMLqhOONzLoiKpF/ELp8u4tZ4yAtSmiBjMJTnr6OET2FfNY898jZRdzgRzj4jo8oWcb
	 RMYJS6jecgB7Ru7HtI973JuFTlrNUNFLB3+xYDRFeVLRaJ5uAt720DHBnzat+xwLSetHs
	 U7grjfjDbPOU2TU+u/Zj6sS1oqhFPLXUVACz+gaNN8u/IVUNxQWbUQMA4GbVjRtqGwjR8
	 nR+nIWmERBySUBS5SqTI5RvHN/oKOhMwMYudu+zPomLTbmx7RmYmS/XU3vzKpAtsko71r
	 SSWYAgF5GVjIoe4dU7LvZ1oL3AODoMu+4G9V8mE7ysg++Oi30uENO1tWzQWpHoO8qMQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791590392;
	bh=kU6Vj+xTfYp4S0bCQgXJlmqRSSxgnofN2Vzuuhirn/E=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=H2ZbMP8xRnT/vXxHioS/XW0LE0ZFvW57lPDX3SgCYW6CHsopmA2BDTdpAMrvg/ghR
	 XxyhDDqGaU+gTpHOTMtHhv7tp65rfl9bp5exYvAHSyC0Xscop2LCirmpJBs3xNJ0tf
	 XG00YkNWeWZfROBxXyV9Ks22yQbOS8sC0QPvLktzDYFkRAmhaUGSYzdTDj8DbSVzCR
	 4DLYrEfcQO/o0JtLLHMmb9An/1EWlkS5AChjzypikgotor9dvu8KpfNy56fb3KuK2p
	 3OMuibCIZEZN/7W3BLa1JRnNm3is9SwhOcSgraXid2u8Z5yFDWwatbTbKtrDFHKdve
	 obMTeR4IWZHgw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5F48B814B5;
	Fri,  9 Oct 2026 23:59:52 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 0D3771DE
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 23:59:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E705060727
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 23:59:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nMf0kd_eUD6i for <u-boot@lists.u-boot-project.org>;
 Fri,  9 Oct 2026 23:59:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E99D460670
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::2"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791590390;
 b=mqH4DZthgaKpZBbYBpKNTEkujcjtAkUC5w+jiC8BO3S7I96gsCv/toNsZgu1Dk7J6S7u
 v/j7uWGoxAvBSDMEnEH6ELf2XseYrODwiqAnB3RzjRMks3pyHJPYpxJaotTg/9Zp5RG0l
 gXWurfCXzYlpFiDkS8KLPObl62ZNeg+34Qo5GGpIGF6Xa5pgpotCfy1gAmr+EOKHah0oN
 iJmYVWtqoNI8j1vEFsUrI75c+IXNcH54mdZ4ykrTegxvm6BVZQHyTDhjC2j1TTfItHkwq
 zPzy1Aenyp5mJWR5e9jPOpmfntbjYKs8V7UBtdSVlipRks8cbl69n0NFa1BMQ5OaU/w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791590390;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer;
 bh=kU6Vj+xTfYp4S0bCQgXJlmqRSSxgnofN2Vzuuhirn/E=;
 b=sk7a6vTriR65O6rn8JHkjkS4OIBcYqtlpS720l4ieZHVdAvDqfSLkmN5UqtgqzHbwEeF
 MgDh5slXxaCJRKoXd8xGh5ggiSodfsWfP66Y1fvxsJqU10353s/dZh9bSRHsYZqc2ZGck
 Rd+6QxyWI9eUkWKn1yUafbk2x7AH+/HTPGlNGtBhGxtDdBEBHipZ5S06T/TOiGNiROmwy
 wgbpgo1di58LIu1dMXwC/jTToK2JQSKLkwVTUJ8wAs7rO/bKXAjoyw1VRHnDnIm8+JEjF
 y3dbCeQX5VImJ5Du2YdAWkeUUlHZ15msTxoIa9M1fMH3Y62SfjgmeSGCDkmU/2jihQQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=l5+d6xOc; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::2"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:31::2;
 helo=mail-oo2-x02.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=l5+d6xOc
Received: from mail-oo2-x02.google.com (mail-oo2-x02.google.com
 [IPv6:2607:f8b0:4864:31::2])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E99D460670
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 23:59:49 +0000 (UTC)
Received: by mail-oo2-x02.google.com with SMTP id
 46e09a7af769-824fdec5521so192383a34.0
 for <u-boot@lists.u-boot-project.org>; Fri, 09 Oct 2026 16:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1791590388; x=1792195188;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kU6Vj+xTfYp4S0bCQgXJlmqRSSxgnofN2Vzuuhirn/E=;
 b=l5+d6xOcatyZpG9JqQXX5jrlYzOgUfEbJ3OtEgDTnilkAIemlXykRQeEw8b0eI1jR8
 ZmD+Y+Lm6cSaN4eerHLJWulgfJv5VcKYBx/tlZ3KgZtTse4Yaejrb/ik5yOebp1x7aoK
 zjctR/Xsdbe9cdpKinnbwm1OGf0zy74LV4XVA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791590388; x=1792195188;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=kU6Vj+xTfYp4S0bCQgXJlmqRSSxgnofN2Vzuuhirn/E=;
 b=kd5felxvGqIwTNjAitVK6t9A8jYBDcIWcgqcq4ggZjshX4htH0B0tgnfAA/FQ3ttGx
 z2OhYTmn4iShJRrp0DUUpRKiRzVsCdZjGE006HFYBgOCAPFjK+HwFdaJtyqFlgtZVjc/
 F2k9d9WtoebluTTs9xlHEvoy0YKHJd0VKZ6PeYLRfIXKGpF8tyJSJ6Jxqba2nmK4wVWm
 SEuzlAABIWoEMyt35SLRyFE2XDCIDWNJxLWfKIKasZQgjYibqRmiWNiw9ZZOzEychduj
 TYZnv5Iejm6H5WW0dbEzfdmXWuaGmFcf15buinFIwJtb3jqIIbXf2HsfRIz8ayabLQIa
 VL9A==
X-Gm-Message-State: AFq9FYJs/TuaE4HmpHMBJ26Ni1DRDVdkvTL8vPvgXyjYH+EswoxBjfLp
 k+a7WGhOXjJbcblJQ759La4kKSeZ+JET9ZtsVyrjqt71JuqVw0Mcm6wyuNfWqNuDEAw=
X-Gm-Gg: AYBFou1MZs8hpC1CPFYn0dI8IR6czarp31MTVqRCm3w0MHXFcONiezsfC+VGuN+onc/
 txtr0P98SGFC57y9/yW0sagwUi3lig7KkGu501WF3TzGNgBtezMvzZWxNKAj+OWrgOYN8fsMc8h
 8VXDKs0DpnEmwN4CG96pPqUqMeM2linnVl+wRzmaKxoiosGRB5BilalvE6Mml5J4As1kjeAhf7U
 /+qSHGCjNPtpdDT4JnmAB1nU4gf8RbhU7uLtebGaMY4ddnM77ifGHrDpgpjbsHxl7zEb8EqqJlQ
 xOHrimLTQTQJclXJeChAtDaK5d662Tqp4WsfzKEyC4if+Vxix0E33WFUsoMxBfh5Y2BPo9LaQc7
 OcU5Vrw8rZxkHWoZwyp+/d9zqxVwIrQOLB7iUz40tSOZCVPbtDSXwJu5Jc8HMwQtNQaQfHVtvqf
 qJLQSm9c5pvkNNeQS2FmCTE2/CvEH5XtXZKg20Ct49cgQnFAjWNQ6Yn6gr6ubQbQdknRttJCjAC
 HL/nTpqi8S2YgxlRR4358RoRImEA8Gl6ojL+OTZ0KALlZKdbl85OS0Snu92dP2trAu1cj0Bb+GB
 ELfa28c5T3WjdGeSGuot4655O/Y0
X-Received: by 2002:a05:6830:3913:b0:81a:9522:f007 with SMTP id
 46e09a7af769-830946a2146mr2704854a34.5.1791590388600; 
 Fri, 09 Oct 2026 16:59:48 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-8303494f79bsm3684158a34.1.2026.10.09.16.59.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2026 16:59:47 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: David Lechner <dlechner@baylibre.com>
Cc: u-boot@lists.u-boot-project.org, GSS_MTK_Uboot_upstream@mediatek.com, 
 Julien Stephan <jstephan@baylibre.com>, Carlo Caione <ccaione@baylibre.com>
In-Reply-To: <20261009200920.2438383-1-dlechner@baylibre.com>
References: <20261009200920.2438383-1-dlechner@baylibre.com>
Subject: Re: [GIT PULL] Please pull mediatek-for-main-2026-10-09 into main
Message-Id: <179159038683.2945004.12272007846327606045.b4-ty@konsulko.com>
Date: Fri, 09 Oct 2026 17:59:46 -0600
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

On Fri, 9 Oct 2026 15:04:46 -0500, David Lechner wrote:

> The following changes since commit 0a55b098d6f5f6bafa84fc2f18b433dd167bf729:
> 
>   Merge patch series "rng: airoha: add support for the Airoha TRNG" (2026-10-08 10:41:43 -0600)
> 
> are available in the Git repository at:
> 
>   https://git.u-boot-project.org/u-boot/custodians/u-boot-mediatek.git tags/mediatek-for-main-2026-10-09
> 
> [...]

Merged into u-boot/main, thanks!

-- 
Tom


