Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E466FC88E53
	for <u-boot@archiver.kernel.org>; Fri, 11 Sep 2026 21:07:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9750280F11;
	Fri, 11 Sep 2026 21:07:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id R_lOFikqRfgB; Fri, 11 Sep 2026 21:07:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org DF28380F30
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789160821;
	b=GBmuGeDuGU5CVhgm5wQFnx7UMeaYvCb5rS8tSKCmteunJl3v6JccAPLRGf8Ju9AFMslp
	 utpc7wZoK7N1U7PavzSMrOwdtYlbgEVGDYBYAEReNHL1PyglBgj9hfReydpNMLidpG870
	 QCtGL5CPWdRqGVvCrTyTNcY/YHBEjXmulMUREaD2MTs1moQbm9Jz0YepVpoMDQdqgPX6h
	 K8q7bh6nkUVcbRW8lgmKdc2QNVfobttBbeZBfgUpdh2FSnIdCqioZNRyjC0iyWKvnSctS
	 XM+xTzl6Vn3lHdORLp7AMjlgKYN1767a7tkYxQrZgeFcSgn1vnc3DMZN7n/czExjf2g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789160821;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=pRdizLTZluiXzfVaCP0hlYRhDeOLLvipgu8WBSu+jnY=;
	b=V/o3FWJkCzVTtAFiyi4j0NkmFTRyLjgOrFbCPImGiMaPVo/Vo7Mogith5F9IXrP69cAf
	 yPWDfpfyKCUrUgcspx2tFpkcwcYM2fP1ep0I8/1adq9JYke5KoBAquUHz6zhaXYKQox/8
	 XQWT182TYPyMcF0dRLq+waP5mWgN5E1pzGdSkl9oHWdPu5McHoLjma6RQ91cO2RmOLjsu
	 VpO1yWjXiY9TtYXhX3zS96ZOkP8g0KauSruO1rAbG5AEI8cYzVBWUvy8z2tIoQ6XHynhv
	 sTsxnB0G7XoguzvrBDmFIpsCwioKuxeMNB64zDlmgI7gI52GJ2s+fCy9QhlQsbrYTHw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=Rnh89Gu6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789160821;
	bh=pRdizLTZluiXzfVaCP0hlYRhDeOLLvipgu8WBSu+jnY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=U1lMI31qlWzAKIgry27+dX0s9jirE0gaqsg3tz0wgsTyc9Jp+3kGxjGTu4vCsWqL+
	 tI23lb+w/gQd2m1YuYCEhZGiRYqgbBzPDDZE9ehOO4CRXUQsUGKou1YaION3Nu+SlW
	 +5Ymyo3wAIkcFgq8TPKqvUKf10woj/BB/NE30R/F9Q2DGs4Vq4XOu4eNFqOj46hUfo
	 QWA48B8Dv1TyedRnz9vYg7iHTlbRtpW65KrMoVKQYuzGEy8pWWNmZN2pxhMhvBnmvt
	 s8SP34jb58HUnS1DxE6uzIm6xeUFSmMfxbwwb/yGJ1y4Ribsr9YnyjgksiZ8BQdG2V
	 0oLJyIQha2n/Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id DF28380F30;
	Fri, 11 Sep 2026 21:07:00 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 55F947AB
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 21:06:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 477A680F30
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 21:06:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tOScJJHnaQaz for <u-boot@lists.u-boot-project.org>;
 Fri, 11 Sep 2026 21:06:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 8909580F11
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::230"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789160817;
 b=Aa8VTfceftj7Ve7Ah0bYw2aDsxHpZesbPX1h8u7lYdYt9bE7b4vIfImmKy1B44LuB7bN
 uEM4DkEQd19jMgZKS4arA904Hkmijpw+LHIwSQ5u7iTlufveDnyRKAipmFvg66Qwtw5ye
 Hh4n7X5EmbdBCgoimImzY65Mj/GHCqeMIfYTEPCWqU6ospL+aX2tHoj6RlW48su6qa/jU
 Q9V+OB01vqUAQ4fDcU5w9jvOFIUii+UiT4kOJI1ORoHkFJ4AV1SXc3WZtthf+vQziUADB
 dsgCdG2Z7OMWkLUpYLBYVPYtv/iWVKiSnJj+XDpjbhJ7Tjz/tWzqetyLXi9VKG+k5dg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789160817;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer;
 bh=pRdizLTZluiXzfVaCP0hlYRhDeOLLvipgu8WBSu+jnY=;
 b=b0JlY2Z3xQMVrHTiDEQNkpWmMUs82iTYz2dX0k0jPY2CHWiu5A82ieTDKScfdM1tzRck
 F58ZJpCJElU5u2ldMrNjCSRYGsiayJfSVpIt4stt/6gE+f/19rQeiDWE7ugcwt+Ss4kGu
 HS3bJq1vqhS0rIedpAbU58kjFJv3O1r09ztMNSll7Q54vJcLR1WDjVr4K9h6TAEd56+j6
 Kof5s6RiCLg/M8IP6hI5y5CNSXgVb0TxF7K+BdqNM8nzoQIgl6TyxxBTprRtR66NAi9I8
 D7wtBQk0KQfWPWaEILWIiwIoaJlF8F6oRVEBjVHmGtZtFUgMrPs34evFX91PsO4m4CQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=Rnh89Gu6; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::230"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::230; helo=mail-oi1-x230.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=Rnh89Gu6
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8909580F11
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 21:06:56 +0000 (UTC)
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-4af173320f9so1101994b6e.2
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 14:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1789160816; x=1789765616;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pRdizLTZluiXzfVaCP0hlYRhDeOLLvipgu8WBSu+jnY=;
 b=Rnh89Gu69Vse25AERSL00LwNXYT2CwnQ+ZO5Y5pp0tftbYNRQ8MSr3tgqsAO/3d7G2
 6ger45vXv1FQp5wWluneDcgdz9TP9T23f/9SGlJ/dx9z1sUVGkeZC1idj3slgfuEV+hy
 Ud9IWXxn2XFKvU8Y7nEgBOWbSN5hh4VgIq7zI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789160816; x=1789765616;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pRdizLTZluiXzfVaCP0hlYRhDeOLLvipgu8WBSu+jnY=;
 b=XWM4tVy5y38OWzkEQF6dcgIpumZcZBtm0a1PR+q8vyBSTUyXr3wlR9IHr+qIjqWU6n
 sXaSM9vu1zndfZLdpoETB1cYReQqb7yjkvyLt4yWyBC1GhVWc41E/GF2xyl5JYBL55DX
 MRdOJyLx6FZDaSMKi9exSRHvXQgK7EGZV+iLo8xUAhx9RnhR1Ms6xD/7S4kwptNYNCmO
 RwqNjFjV/GFxFHQodqMBB1fdyRq+83AVGRZD2VCqLOAtj4uhb4+1YGQk/vK242JGdXrM
 inOtp7PBVv2qz4w5JT3bkPVk8b6nH/TVQ9jR8i73Om453vRvg0q/QT2jZDa6Cln8Gqiv
 WRew==
X-Gm-Message-State: AFuF++lqdTnlDROM98Ihq+z/k42neqtzOY2og+lo5CdupHHY3ScksfYT
 5u3FPUMZujX51eCbAMWxPIP7jMDXK6PUkFKrvevR24EA3nK+tEFXqAoaKBvB3ZfQLBk=
X-Gm-Gg: AYBFou0bqLmHAUSwCQxJWQ1jAP3Kqjq3PUhxX4N+rldX6kVINgav7GtR24PSNbsUdVm
 msB4Q8vclGhSxP0s9soga8F/tgYMeULPhsMdJ97YbtCrw0F1nieD/FgrZxhVoEAgX7UAxDKRKha
 s7E7l9XE2TN3vMoO1Oj//UD1qmVYu7r8uO3QSpNgjasgaJvKHHyztJ5DcZ986VScNRFqRVsTfTq
 XPJIo34soCW1ACjqA6JipVKrDPRrtNbp2K5Wo3tkPvQRSOjr40o6eflGrq+sQ/u4LcguVhutMgu
 3RTT5D2cdNME7VgpqoHJT3Ag9Wn4NnWSRJdPpqIPCXge4hpnx4eHIKQhzJgJQRdVI1lUdW3gX00
 UMGq0v12ARZJjgTB7Wq0ysxzzVs9/ZYd0IcUuplLfAofFAEOFRnrHsDQklCv6vXm10AtUKVKANW
 7XyQP5G8OhQ1qcVcRgZZIqCRecy5j7LRIyXDZ/NJfZC2up2CUOCc11bkIH63oEmRkQX2VXRxCBX
 8tcU3OTihhVbxObRcyQ0pefJg+16t8bceC2CYP3UClcpdxlh0zQGfCST4XJUJp/sIAep/+9XkuM
 GRhAGjvxB6HptuT9uwo4PoGxBO9Ahzg=
X-Received: by 2002:a05:6808:12b3:b0:4c3:e608:ade7 with SMTP id
 5614622812f47-4c3e608aec6mr2410566b6e.11.1789160816077; 
 Fri, 11 Sep 2026 14:06:56 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4c32bde3858sm3197723b6e.0.2026.09.11.14.06.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 14:06:55 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: David Lechner <dlechner@baylibre.com>, 
 James Hilliard <james.hilliard1@gmail.com>, Simon Glass <sjg@chromium.org>
In-Reply-To: <20260910144638.9642-1-marek.vasut+renesas@mailbox.org>
References: <20260910144638.9642-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH] env: Update description of single to redundant
 environment upgrade path
Message-Id: <178916081489.3818440.2968717808951059942.b4-ty@konsulko.com>
Date: Fri, 11 Sep 2026 15:06:54 -0600
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

On Thu, 10 Sep 2026 16:46:15 +0200, Marek Vasut wrote:

> Slightly rephrase the Kconfig symbol description. No functional change.
> 
> 

Applied to u-boot/main, thanks!

[1/1] env: Update description of single to redundant environment upgrade path
      commit: caa02d5602a4d2067bbcdb8515ec14535364e317
-- 
Tom


