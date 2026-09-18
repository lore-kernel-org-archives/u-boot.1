Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A078C982D8
	for <u-boot@archiver.kernel.org>; Fri, 18 Sep 2026 16:35:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E128840BBB;
	Fri, 18 Sep 2026 16:35:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id snPf7byCngYn; Fri, 18 Sep 2026 16:35:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 0DDC040B67
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789749308;
	b=AgKLWheExdl7yjCbX9N5b6Xx+y453bcDkqZm63kZVLBURh7mxK47xUPMNhB27+dqqBR0
	 //ydf++xwqVKVE8jVOj+FZx9B4Ib5mK277URqNiJcyKG6TnNvu3iNQUAUqhA+ac6RQfYR
	 O7MoMpq5WZO6JLYyMv1ghlpV3Ah41O9aeYUhsGBD8mCKmhbcclujfPLO7eUNvFRRPqq1m
	 PEAaHxU8gv9jn18j4WUJXfYNvA6W1h0ANMzrmwFyZLq+BmhUFI9TrobhShPNBufliJq0N
	 2Ly7gB9c143r4qJiRzWqIIo7PzwYLv1Yw0rDGdfEXRxkpAPqjWwmo6FpgG08W5Thzjg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789749308;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 Received:DKIM-Signature:Received:From:To:Cc:In-Reply-To:References:
	 Subject:Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer:X-Infomaniak-Routing:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=TXdJKDwMihlUWw7Js3AOvqN09oNQwg9PetYkoEjQ6uk=;
	b=CDyLJ5sVvYNQamJW3hektj0DXzn1rgU9D3iEk23nahUc7paVPdGg5f1eoPr+EoqXiG+C
	 K8ciSGQtOGhwGRZ51n5PU4ACQZbownMrIsUBWdZb0dW6VqOaKPErKsX4edabaseZleeSx
	 dDEhgira26A9/ViEejBUqqWAxpZwn1x5IWWydyT6FqdC1am4q8MlnJHy8tNpJGwWvVXDo
	 tXD1o8RBURFwcl+BNxkvwtbtRovqNFWUbfYk1lbdRXHBrBlaO+fPYA4aIY2ZELiDVbRvH
	 yicOKK8aggL2to/1J21Rzal3WntE5XgshJUKi7EEmPGPoSAP3Eset8U6QYClupLPa7A==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=0leil.net;
	dkim=pass header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256 header.s=20231125 header.b="fzoz6W/h";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789749308;
	bh=TXdJKDwMihlUWw7Js3AOvqN09oNQwg9PetYkoEjQ6uk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gvkLbZcvDGW7AIdogiSxzXZ9aFK6OjOXG7G8Mud91JYcp+9ip6XpSu1obs5QSIEwK
	 oj2ebIxSdysVxuakuPQpcXVoROZZtkZgumTBQMNszZqDLANnq7FEVxN0XfnZM0d5k0
	 C6VNEMfnV2sXlie42fgN9tSWa+Yw6DJwzy3PbhUbueMlIBuUZgru23UZdnpYNKDcOg
	 sXQujkqUr/fQ2apwmEMEOGLmLbfSJIxaxd1M6zAxNN2/2wrAuV/KhbGiLUCu9V/jsL
	 hPraVXBMxii44ngyAWPv0RnsRSWNJEY357frRWj9j6zKhM3fS4tSwKazRC8lymrJX+
	 DzrkQn2rDbzzQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0DDC040B67;
	Fri, 18 Sep 2026 16:35:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 744503B9
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 16:35:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 64EBA40B67
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 16:35:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id m22te1KqsMm7 for <u-boot@lists.u-boot-project.org>;
 Fri, 18 Sep 2026 16:35:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 485E840B65
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2001:1600:19:8e30::1909"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789749305;
 b=oobNoe4UQF5kVpU38yYcyD3Ow69X0kLHsO43fxDNvhiwta4A9VmO9oGZlVoJKx3l2vFQ
 +Ljl3yL4LLuomfUVTHQOgmhKiL0ZOF62tpL2JYxLj10yj5D5EaUGBOAHmMIE1fxDGnmE+
 P19LACvWS1626/yeOLHlE7p1ZkE9PAe5b76lGOyOnxwaAhtjxcnp/GZov5kWnsshMUdfx
 /yzO91bs7rXNAcnPoLn8JhmZFU7Kc8LEPTAvFYJdcndot+uNjL3ZYgvH/+VGxfjhAadvP
 gjRBBctGPbzvvQNsskfpVLoNa81vm67YdZDVdORmeLD+eJAjpbYNgdeZmuU21o3mSnQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789749305;
 h=X-Greylist:Received-SPF:Received:DKIM-Signature:Received:From:To:Cc:
 In-Reply-To:References:Subject:Message-Id:Date:MIME-Version:
 Content-Type:Content-Transfer-Encoding:X-Mailer:X-Infomaniak-Routing;
 bh=TXdJKDwMihlUWw7Js3AOvqN09oNQwg9PetYkoEjQ6uk=;
 b=oAe1YhlqsyGc4zxWkMJOMeWpdKfUIwGs9/PPTmmTie8P3voXO1TmWp/YvXLg1FEwCe+M
 SnYUNicoTiinT9qV/B9cKlaLPltWOJ/2oNqgkVskBcSY7t+Igzge1ELXX1EMFRI+0Byg8
 Md3tSIM5pvv5LEdhGMba+FYAGGVBmQhJI/b9CYLaDM0/zdgpk4TUoZVLlDehJS6BsjcgB
 raV76kWeZIPtCfNzOwiY69IsG9+So/GbrMKQM79Ck3gbgrdprJbdoWi1OaY3HyLKzYgmX
 kiPDyeVc44ikgieRBs6scNag5cHbwr5aCUS5Mz1aF0l2PrUoR4lVrqXkk8HMhGzUzXg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=0leil.net; 
 dkim=pass header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256
 header.s=20231125 header.b="fzoz6W/h"; 
 arc=none smtp.remote-ip="2001:1600:19:8e30::1909"
X-Greylist: delayed 91390 seconds by postgrey-1.37 at util1.osuosl.org;
 Fri, 18 Sep 2026 16:35:03 UTC
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256
 header.s=20231125 header.b=fzoz6W/h
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:1600:19:8e30::1909; helo=smtp-1909.mail.infomaniak.ch;
 envelope-from=u-boot@0leil.net; receiver=<UNKNOWN> 
Received: from smtp-1909.mail.infomaniak.ch (smtp-1909.mail.infomaniak.ch
 [IPv6:2001:1600:19:8e30::1909])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 485E840B65
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 16:35:02 +0000 (UTC)
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch
 [10.7.10.108])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hmdWm2Bl6zrsr;
 Fri, 18 Sep 2026 18:35:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1789749300;
 bh=TXdJKDwMihlUWw7Js3AOvqN09oNQwg9PetYkoEjQ6uk=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=fzoz6W/hX6fhHcIGC1sV0yK3x3dimKPX0ca9G2qjHAShUDTAxk0G6tymsO+tTTm7g
 r847SXZooR0DhUCORzRSoub760opUB9Qu95xmHEZxyUe4frkyxaYojaMTvvMfaiSAL
 /dq3Y++6GSDyKvK3ZFxq1MtdfZn2S0FOkaViEVFSI1ElptkFDzqm83wrQL/XGVK3dp
 vUeG915yvZIs+yvKvnu72FAvIMkSLXnANNFqxVJ0COR0PJ3pBoeMPwRN0UlifEJOUw
 TlzOVuvz189fIK/ZvXpgsld30/LgiF0gBFmYArG5jXQuTgO+Kdw8zamezz6c8T9p/N
 eHQyjuDBbxv7Q==
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4hmdWk1Rwhz6tY; Fri, 18 Sep 2026 18:34:58 +0200 (CEST)
From: Quentin Schulz <u-boot@0leil.net>
To: u-boot@lists.u-boot-project.org, Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
In-Reply-To: <20260904131951.44451-1-pengpeng@iscas.ac.cn>
References: <20260904131951.44451-1-pengpeng@iscas.ac.cn>
Subject: Re: [PATCH] fastboot: fix the RK3328 buffer-address default
Message-Id: <178974929808.351239.12659615125115508649.b4-ty@b4>
Date: Fri, 18 Sep 2026 18:34:58 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Infomaniak-Routing: alpha
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

On Fri, 04 Sep 2026 21:19:42 +0800, Pengpeng Hou wrote:
> The default fastboot buffer address tests ROCKCHIP_RK3329, but U-Boot has
> no such SoC symbol. The supported SoC is ROCKCHIP_RK3328.
> 
> Use the existing RK3328 symbol so custom RK3328 configurations that do
> not override FASTBOOT_BUF_ADDR receive the intended Rockchip default.
> Existing in-tree RK3328 defconfigs that set the address explicitly are
> unchanged.
> 
> [...]

Applied to https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip (u-boot-rockchip-2026.10), thanks!

[1/1] fastboot: fix the RK3328 buffer-address default
      https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip/-/commit/1dac5d806ba8df6857e453064c12d52510933d28

Best regards,
-- 
Quentin Schulz <u-boot@0leil.net>

