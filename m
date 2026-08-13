Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB956C5B572
	for <u-boot@archiver.kernel.org>; Thu, 13 Aug 2026 17:28:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 91DAD812EA;
	Thu, 13 Aug 2026 17:28:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id H25aNqrndk-Z; Thu, 13 Aug 2026 17:28:52 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BA3C4812F8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786642131;
	bh=9L+vwk+isF1Psr3KMk+l8nU8UmkdD4KlvGqPyx83nnM=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0lGo9RUswrK/Rscg+ttDet+GND1Nixo85ZFV4iEz1qfj/7R1uqvX64yp9g9nsXRBi
	 dCSsiMUhhcG+R1bbLoH5HshAnVZ7oPqtlzVZffNs398XHgd9fLuW7CdGAzlz8qQd4P
	 7g+3Qv0aGsQ8+N1nwjI80oF8S/Hqt0MbYcKRgPkuGnAYuttrOlIahpOu7Ryf1OeZYb
	 yPTPR5ZOdFxJIwFp5O2xFWaFFHrLEISVRdErfCGAB5cTV6tEC/VFkg/ZCOnuCH8d7E
	 +fbqK7Yx8MD2BK2zbGTT/BU90/qhNYFBEBsgXzitp1uqS/2j4vi1k+8qv80IHo5VMd
	 KmvzXHaIFb23A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id BA3C4812F8;
	Thu, 13 Aug 2026 17:28:51 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 8263C2DD
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 17:28:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 681B140807
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 17:28:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gbssE8WFgAcY for <u-boot@lists.u-boot-project.org>;
 Thu, 13 Aug 2026 17:28:45 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c30; helo=mail-oo1-xc30.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org B207340809
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B207340809
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com
 [IPv6:2607:f8b0:4864:20::c30])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B207340809
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 17:28:45 +0000 (UTC)
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-6ae8445b7b6so108662eaf.0
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 10:28:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786642124; x=1787246924;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:to:from:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=9L+vwk+isF1Psr3KMk+l8nU8UmkdD4KlvGqPyx83nnM=;
 b=E2qTAnrjED2rexIU0AMLinKaM5o3y5k3YV2nYm97pkoILHgS/WVsNUh7EyUEeQHYeI
 5vzZT+JFz8ZI7ZlQ4S093ioc5rTvJs8wPuSoFbBnXdnwX1rYdsNQQN3oHPUTC8w8FhTs
 TiOOe2eBYgGemu67p0vd/8ZmybqLjRhd2eEc1Q7bGcoEEdvMOaMkKE+n5ilqDkPAbnqw
 1qHmabNz6WC8un79WRlR4KaBRlvOGhizaQAcDkovHj/tS7Pa/5dRgwl765A5et7YKUFU
 CfUM6BW+QHv2CMO1ssVC3Edv7P7XjKLO0U6wTIXrSCtn6xabTxr8qVx6q0ZuUdirml6c
 SDJg==
X-Gm-Message-State: AOJu0YzvkpkvqaEQ1Ro7fFCOjue7AwgzqDlgqd//SEzxymJzfW7OmiH6
 3+Eh8GsI3WJS5S9Ua5BizWLnoOvdUjta5FtSw/s0nHVn2u4Pmv00PwKaPdvIQxVJ5Sw=
X-Gm-Gg: AR+sD12sXVQ4LyIx2xJIBi7XwIX9xQ3uGjTrj5Ah2wvXPdm+ddPK6nWjCdmNnW7TDce
 5UzpB60gFs1DaPK3ZZCpps5G5BJfPayPLLllvOGR+1W2AcNRuGStP1Y+4AwvuDhX24+cm6NIlFn
 /AQEfIaSQZcmUNOT4nEvX9JQOYTftC9pOJCjO0czr+GNDBxG1710QCecrjh09EAwdhTxfnTkO4n
 svS9YlFbw+lh7jn3N9SfmPCjHDPAcyYRFhrBnyTws5bkpMbCfDVe5e5/gnRVewA0eiNmNDmwMaP
 xJYsxKx8XBlNBfllseLPJwh8LFxRnjJRnmIT/a2Dw+jkBlIL8gj0eYvA1K1a+4U7cTsc4BwtQXw
 DjJNcSdj0Rw7H6vQ7mJa8IykRrP9G6DtvW5Ksak2kOvYYR/Diro0Wr1W6oPRrx4xeRrQycgWf1l
 Vu0BmrJHJzB65VNPWFu7cHAl9LjaV7fRuY4WhFWVLvj3WmZM+fIQ7jsTXx5zutmjewLw1KFqLab
 VoX58N7ah7Wmj0BOiU32oahgvVwdbL1ooDL3tmaE9gofkkn4R033ASRuCzCRf4RBSBXYmEXDrxI
 mqFnt/au
X-Received: by 2002:a05:6820:201b:b0:6b0:589e:42f4 with SMTP id
 006d021491bc7-6b0d6245e3bmr46386eaf.20.1786642124542; 
 Thu, 13 Aug 2026 10:28:44 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6b0c42b7c97sm2962754eaf.5.2026.08.13.10.28.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 10:28:44 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, 
 Jaipaul Cheernam <jaipaul.cheernam@est.tech>
In-Reply-To: <20260811133433.18852-1-jaipaul.cheernam@est.tech>
References: <20260811133433.18852-1-jaipaul.cheernam@est.tech>
Subject: Re: [PATCH] pylibfdt: Replace removed SWIG Python 2 compatibility
 macros
Message-Id: <178664212400.3617045.5918029182707632556.b4-ty@konsulko.com>
Date: Thu, 13 Aug 2026 11:28:44 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1786642124; x=1787246924;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9L+vwk+isF1Psr3KMk+l8nU8UmkdD4KlvGqPyx83nnM=;
 b=BBAKKnNhcYHY40G7+vdpWSr6CpJ0NYAdZxVUx2vGs626MQILHZ434qcKsJP2e2RU2Q
 joi+Qup+2HvKpoJpHRKv5Hy3Il+9+5emQk7rzTSYVaxeBkrwprUglGg07i72m9EOBo+d
 S1Dl08Zrxol6STq6IeUhHmhgg5+9LJqq/8zhE=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=konsulko.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=BBAKKnNh
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

On Tue, 11 Aug 2026 15:34:33 +0200, Jaipaul Cheernam wrote:

> SWIG 4.5.0 removed Python 2 compatibility macros (PyInt_*, PyString_*)
> from its runtime header pyhead.swg (see commit 79f7a2b7cb7d). Replace
> them with their Python 3 C API equivalents:
> 
> - PyString_FromString -> PyUnicode_FromString
> - PyString_AsString -> PyBytes_AsString
> - PyInt_AsLong -> PyLong_AsLong
> 
> [...]

Applied to u-boot/main, thanks!

[1/1] pylibfdt: Replace removed SWIG Python 2 compatibility macros
      commit: 527115ef6783cec49e5610c523c124b399011361
-- 
Tom


