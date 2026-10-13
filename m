Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4E50CC6B19
	for <u-boot@archiver.kernel.org>; Tue, 13 Oct 2026 16:46:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 91581808C0;
	Tue, 13 Oct 2026 16:46:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7fNm4S-2HN9W; Tue, 13 Oct 2026 16:46:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org BBF4180DFD
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791909968;
	b=MEd+r6B6d2PO3wsgwwDsvuzfySYA7eN2vftKjWmOfOG8PXSk45r8+xUqO+Nuh0uIYHdV
	 KWfchKzrKqhG8Y0LLsGtMKljwpxwEBwElp5eoCa1wOE9bdlnEIOWkangxAUbDcFun0mdg
	 XyjfjdiW5T6VsNXRz19xSG9eQwFyQfPr/Uy+L+ixXJQ/QIeSUz7wKdP7HHB7XMDZjy4nL
	 f/Z7Qhg/nTZPJ/PdbsHyGBwCV9xhPBTz+kaMoXfMYaCNjjythe4u6OVT7vsa/FzMfCoBh
	 NNka1tT5QdDFiMZn9mD4poNs+V1jv2jiqpFsgIAH9nw9PskTZnZ13VXoLcuC4gC9Zbg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791909968;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=9ufCmFA4atlZBBmeHlpZ4UiCl5NA2tY+rAzinlPORlk=;
	b=E0vE/kg6Ud3TiddoBiVuJELzFlDyHAppJjD176b+M7fMqJ+RrfwI3MmO0qxHIR7RN9SD
	 vKuXHT+RaKoti+ztvWbcOL/j+unUugT3rq2VCY5xzP+ZPRVa3XNVOF0zpEF3NA+mTz487
	 pdnyzTfieMjouJ3eMZpdoG/uHqktiu2tJjFjzTBUoejelDiH1KPEKLqRVDFwAxl+5Y3Bk
	 lgfK7XvGhLS19puQ06Gl5IQVKzhwmSrC5i7Q3S1z9TJ4T2FkT6VNkWwInxNK35ABmllli
	 gfW2c5Ek9hdDmxeHLcl8zcZjNEtSEPWcAq+PhM01QmTMHaCCatl+Wf8QE65G79Stdcw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=reNck8Ju;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791909968;
	bh=9ufCmFA4atlZBBmeHlpZ4UiCl5NA2tY+rAzinlPORlk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Wceg74stKEvxnDNNtRmSlOTQAS6OeDdDAx2c95pxODOf+RBk5x/AgcEYQFl+xgfWg
	 JpmlMQpY+Wwo8cskaiq0gcLGMFBL5yqQISG20PrWbvpZvohRCcFJRRCb7f27ikLvcD
	 2y2LlDHA/y5V/d7LB9uvU2cxpLDmPQUyPYnv1NwxAVdOzKt5K5Au+vXaa83CrRg5Ji
	 Wxfi7619i5aFbgpPjeFuYOIt364GN/h6uHkaP6fpwX7g3dx6Fz4wcTivaH4lFvhGsV
	 MQcsTX3A2/0NyupFTUhrk6lMbRyOoRYKfjEHG7h4o921qKb+MZlxagbuHVsMNn1feL
	 0XKRVBeI3o5PA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id BBF4180DFD;
	Tue, 13 Oct 2026 16:46:08 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id AA45CDE0
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 16:46:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 88F13808C0
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 16:46:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ARLZ8wHm4pbK for <u-boot@lists.u-boot-project.org>;
 Tue, 13 Oct 2026 16:46:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B480C80DFD
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:32::b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791909965;
 b=Oz1CYtEbKI9d1Dou2XySPm7nqPhapXuiI/xZ/7WqY8CivW0RjRa3R1acHVLiVHct876I
 KiBjLNHejuzzjW5LmqFVaMVGnnWjwlUDdtPIlfoovvfEEF7Glnrg/oBXrGMSM/yItw7VY
 W88vS+QbK3H0KXTyVbhEIMIRoX7vlbqHWlHOYyH7d6Os0es83Vs0/+qzt8skcIj04wcqO
 BxOBIpXZHis+8gy0I1IO8czCDZjcp54aDRMYv1MnWozFsTqiKSF/1Ovh6rsuzypi73aL+
 CozIZf20Yn3APFr9IzMQ4nFMk5c+NYZTYVZmA8VgNJyIBa0IDd4Tb0nyNlpZtgg515w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791909965;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer;
 bh=9ufCmFA4atlZBBmeHlpZ4UiCl5NA2tY+rAzinlPORlk=;
 b=g8mFCHckiUeHZGM6CdQHy5GwPR3lX2krarUeOqwWjj7AXFpPY8JBW893ui9dl1Xs0af3
 Wg3g+B6b5ab4m8+3INgotw9xkNnkCd4EaG9rHANryk6v/6GlSbaqQy/ObW/FKy4ykpwWr
 x8BXLXipe0DOujUetdjdJP5hIvdLF69+V1HRwRJARdVMhfOPt4FRG422qE6uN+Edp6hlH
 Y8175u93F4DHC6lga0F/eQiAYUNjy/YTSPMDunSYFcr6u+Pn/2xM8ppcThpyL+aCV3qDH
 X5fKksgVT7LYKB18gP4NNKtFQMqsbpesJYbNHH5vX9l4Ctj5PSFz1jc0n4r+9Gn1ciw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=reNck8Ju; 
 arc=none smtp.remote-ip="2607:f8b0:4864:32::b"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:32::b;
 helo=mail-oi2-x0b.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=reNck8Ju
Received: from mail-oi2-x0b.google.com (mail-oi2-x0b.google.com
 [IPv6:2607:f8b0:4864:32::b])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B480C80DFD
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 16:46:05 +0000 (UTC)
Received: by mail-oi2-x0b.google.com with SMTP id
 5614622812f47-51cddc2451aso746737b6e.0
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 09:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1791909964; x=1792514764;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9ufCmFA4atlZBBmeHlpZ4UiCl5NA2tY+rAzinlPORlk=;
 b=reNck8Ju8xhq2k9VeL50xRNyU3fZ4qGD8Q/Lte7IKpk6IEyvZX/78mNBPXd/TCHCqD
 QNvUGL4w0itV30Nxdpk716tJXyr1b0rVTJOMwMyY5c+76TN2L3+OXE8yRZVgBEj0EWIa
 SGyoeOvIxaz/DjXdljbb0VpVEBcMDxKXvrkkU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791909964; x=1792514764;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9ufCmFA4atlZBBmeHlpZ4UiCl5NA2tY+rAzinlPORlk=;
 b=Qc7mTFnHqbTrl0stbXe71xxodlpWnkcjFRnvC3SggA7X/X4fthUCh7x85br41i0KVX
 Or5WWTL/EUhfCtfRdpG/rkqgH8SkhnoK7zj7aSnJzIV4NmT/0WA1SEvnVGHxyhkQYyd+
 cxo3D3Yob55pVvOnTkWmgsGqCLfuIPpUw3h2vSLMpDZ5ppuZAGDdsdFDsdrqysRBqxN0
 jLxiGKoxdh0Moq4v5M6AtBpJioeCWCjX8ug24a3vAJb7L59kx5BAfI2Y7FCCTgbU7XJ0
 BTpOEt1WjJCWBbNgOyUIEJ7KlH1+98/xk56EOw6n4KLJ7DBk1C0tIIkgP+gb5f6+Xnbv
 Rjqg==
X-Gm-Message-State: AFq9FYKTQayZ/Q9TVy6Xi/rXFkWIrHxpYMQmo504bPB8bD0pEYyTR4Ty
 cJ2+TYaN15RB0d3bjUkxSrl3rEd9ZVUSyhS3O+bLKWLMAuQt64epxDQbf20tGBAuHNbU+BgZnLi
 GLeOi0tjmy52qgCs=
X-Gm-Gg: AYBFou1r1LCB6v7J4DfE4VPE7FwmavsL5/hRGEB9JN95J3dIcjZwPf00ZYQNlV047VK
 iBHTVovNWdBv73J41nupFxq6m3mjnn+uJry6iK9OE0tddY58Zl/CRdI24B4333QZooSG09NB8cM
 DWYiBQMdHzmTOTqfmlS/3C7N9VMfYs5n3UR0JOyXOk+IMROFvdGGFv1Qt5g6RLwO2uMQZaLEBle
 Vq6dqm87EmC61OvI9+gG7fFJNuWgVE+YjetBb1OiJfdOJWkAlSZ5nwbtjd/beEt+QgJ7svkBhnJ
 HyrBqBtDW+gwQwm/vkXPM1HL89rn495BWlljclAg20w27A5f6IyOfeiVkmgC+ohD310tw0gxZ0Z
 3tHDaStBkR58O1tAf/xybsI0+tyY/Sc1gD8Uus1KHLgFtc2Fcr8Ni8x3ZpXJCca0BjNgldaZghV
 JlFGL1doCglxWJe2TYBP1O5Xw4ON2iN2aMJ1yGa17Ex5ie8/VocmSzuCEpYoZG/QlEziy3eD48V
 5zbJeRFdxfWdwjRA2206GdC5kwxuhJVIBAjO+7YM/agA5Jst4cdQ6e0d+K/raqtjy01qZsuuD3J
 AS8faaNMtqDEpNfcQg==
X-Received: by 2002:a05:6808:e84:b0:4e8:9edf:189a with SMTP id
 5614622812f47-50c532f47aamr11224613b6e.12.1791909964028; 
 Tue, 13 Oct 2026 09:46:04 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-50bfe56242bsm14657967b6e.0.2026.10.13.09.46.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 09:46:03 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Jerome Forissier <jerome.forissier@arm.com>
Cc: u-boot@lists.u-boot-project.org, nd <nd@arm.com>
In-Reply-To: <f21a86c4-9a2e-4eaf-9e77-3224fb6b54b9@arm.com>
References: <f21a86c4-9a2e-4eaf-9e77-3224fb6b54b9@arm.com>
Subject: Re: Please pull net-20261013
Message-Id: <179190996313.4070495.2076083910935139220.b4-ty@konsulko.com>
Date: Tue, 13 Oct 2026 10:46:03 -0600
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

On Tue, 13 Oct 2026 13:37:27 +0200, Jerome Forissier wrote:

> The following changes since commit fed92546960a92177d67c0b8d7b22385f50fed29:
> 
>   Gitlab CI: sage: Update for labgrid 26.0 behavior (2026-10-12 11:13:40 -0600)
> 
> are available in the Git repository at:
> 
>   https://git.u-boot-project.org/u-boot/custodians/u-boot-net.git/ tags/net-20261013
> 
> [...]

Merged into u-boot/main, thanks!

-- 
Tom


