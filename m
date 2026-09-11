Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30513C88E4A
	for <u-boot@archiver.kernel.org>; Fri, 11 Sep 2026 11:45:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E60A980D64;
	Fri, 11 Sep 2026 11:44:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zIxoGxfme36e; Fri, 11 Sep 2026 11:44:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 39B6880D7D
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789127097;
	b=c5z1Wm85DI2BdjXpbpQ9KnC1oGGmgrJ7Xu81extJQlEB0zm7PclD/D/QbxMgJct9ZFfj
	 8MzprS+hD9zsafIlGoXs0ekQQxYkdAROdfrAPNuCRY7bqnyigvRuQMeLjFWt9yyTHYSQ5
	 lhspe5P94+wWVKQ9FybXZMB+JdG+2r+aWWRtiJ7cC8JB/9UVrC/7w6/4EiO2VSJRKtofV
	 NB8T5zqAUew+i7+/CWV2vMfY54BOV2zYwkZ34L2Oe/O3+5bUIExEsbGwHZ0SsOqjOeJu8
	 JxMsOgw+tlhNVA3UOskltNKwas2mUIAvehjOXgv4OigCkvMMq6oDIH6tWTZex33iU4Q==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789127097;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=nPakNwyBUrTKD3VhGX0wMLO7+pZjbIJcBRqTwK3EC6Q=;
	b=IsCojljEzqURzBo1FVjteMGYpEvPbNTaYxAlDs7o/hFONHAE6OXJorHxZRrsApWcbdbq
	 qHUS8W3FBTcgXtzWgxOnWab5wD0KdFHol2b3Tpxbyi5xTE6DPfp/rmWpzZ8i4XidPjCDh
	 Hv16/vyeignc4cO36koPZ9V9yRLsntfzaJxvUsZ+rbOzSWf74ECmPQc1ZROOELHPvHvwm
	 P1LWng5FurqH+f4JntXR07NaftbrVo15eFHBG1UptQo6aEl3Gt7uvQyG+sPDnO0qgH73e
	 RiSrfAqGDztYa7Egt83UduaMhOiaBV7CkbHSPnrUcZMk+JbU/8P/BxQUwuh2OBikKlA==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789127097;
	bh=nPakNwyBUrTKD3VhGX0wMLO7+pZjbIJcBRqTwK3EC6Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jkCEyso0csY64zeBd5WdRXKdRycV/rkmA4xKGLdT+EiI7mv75Z0j0kb/j4UeyFHtq
	 2QgcJTgkspiBvQq+RuPgKCcoPRRdmtXgs9vg18cnIrfHDmyz6BRspK9u5DdysPolFV
	 FdM9fOxNlXGX0CXV1BeqmiZcKb3H7v0+WRFkt2RSn3a29nqRKBHwyJuIqFu4EDjREa
	 YhN4PS29mRDUvfcl7aC8x+lt+8c4qK1jhJWE1hvsJX2V78YUmRY+hFRkB/Urwj5g4/
	 zmeB+hU6nNr/9T6AlGxOy9t6+7KATBDneviJFQUxN/nIBPbILm2sC8TkLqZ4Yfx++r
	 67d5pCKkY66cg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 39B6880D7D;
	Fri, 11 Sep 2026 11:44:57 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 9D57732F
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 11:44:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8DE0940340
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 11:44:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id N8y4t8xtHiiV for <u-boot@lists.u-boot-project.org>;
 Fri, 11 Sep 2026 11:44:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 72C3340334
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::531"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789127094;
 b=APAcSGJmbLdICYw5dRhUS2fsPvqfbyc3D2ZkFYQcj1D/a8/5nmAwVnxcAQiMSWYSkDKh
 KYnYIX6bGNJ+dzIc4Eimy739jHR5JoLWUX+aeq3T007WFK0MYdFaMBXuc8a0ree4gGmTI
 CBWwyZLhNsGMHnnwVy1Hju3FW8Z1BMicir4Rt6elIBRPUUqbBTUEjsB66o5wG8j9X1RiP
 TUTXWNetlIYTjzaVTHZ/Y1M1WygqOGWHm5v1EycIhwltwwtmfgjQzHgM+gpVzIYr0ZXaL
 GobMPnSZZQbUsHE1ChkLvWV+wbgtENRe0oYq/RCfygltvUGXbQu+PgsLa7KKwwdAGOw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789127094;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=nPakNwyBUrTKD3VhGX0wMLO7+pZjbIJcBRqTwK3EC6Q=;
 b=Ny4tchF1keathQ79/+zOFaWenWLP4DuOZfBv9W13L/5CCUBOwmN6l8+OEO78Q7xI38jc
 4VEZaLEIldgsKXgZj1WknYb1TQkIdW/ObQaYzIowzhOElIQTQ8wzZTlmAhRhYuQFJiGrW
 iFCGEhvO79rJlR5W/jG1rRkSfLxSROKJGfjGF9DD1pJagOd2RZb2B+75wGRNl8bLsW9Vv
 XAlZyqe/A/WhhuaPnFfvtYiX1WmYia6iAB/WzHWQXY0RbXn2apMpV5RB8pW93E84Uz0k6
 MMdgTFN7O4junW4AhBsvKV+4wDgJrys58b9TjIn+WdEekPCgR7ze2qwwAPa/36dUVwg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=chromium.org; 
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b="bck9HM/0"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::531"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::531; helo=mail-ed1-x531.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=bck9HM/0
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 72C3340334
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 11:44:52 +0000 (UTC)
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-69f7fa1c548so1292006a12.2
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 04:44:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789127091; cv=none;
 d=google.com; s=arc-20260327;
 b=l0uLpHV/gHHkbVUzZFQMA9IQlCpodJT3p2w7sRjvOAOVpRl4NkpCBlMD2VlYISQXUE
 Zv1WAxCZYLpAj9RZJjB6+ZzKbX4YkJs8HJk2JwhX3DTWCqh8DAY+A4sdMfYuvXVWmHAz
 8ncMGqFXSQKDNCYdXjobtQ8sYxcfyRe/Bnzb9RLxCWzyNQC2+oFCl8zTQG+x1LiQVxpn
 Cmv3LDNFbbCbwNI05udqr1D6iZp2h009ONAAGDWZhCxx8Uj8Ds0rHIccx4EJIYmFWflg
 gS/ORieZ43Egwbb167K2FWgBbNJnEkDtgdRmLSDaPb3B5fV3TrRsP6PsLyPvsSAltYDv
 fEVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=nPakNwyBUrTKD3VhGX0wMLO7+pZjbIJcBRqTwK3EC6Q=;
 fh=gdHmp5AI9bJZ/JlIlkQPXM6ua93AVYrH57S1GB590mw=;
 b=sZTyDJkhuTF/zs47Yafp5/ECXoUVeNLDQr7EjcK/dnpcqr4ZARmrXqyZCT0ImR4A6s
 oVTWiTmkv9SwYL77MJEp1fiqMBsqHt/tAC47lRO9s6FHGfd0QoDGvz8v1pfGAx7oieTX
 mPL0B903eLcOgoD0RW9vsw6TCk5c64pieKjU3qqVa/Jvf/3PEjpVmiEWdZWo2cssk5Iy
 y6OQm3cAt097NBNGpIVz+kxAjyShe4RLSn1OTd+nfTYH0iYKP2h3+3S9edHVEPuCWz4H
 gKIQr62vVrhd0mU+4g2xfjpmhESCYeU021AT/Zw5HoqHJsx0rZQ6R9nvA2zoG4Ys7SEh
 M4RQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1789127091; x=1789731891;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=nPakNwyBUrTKD3VhGX0wMLO7+pZjbIJcBRqTwK3EC6Q=;
 b=bck9HM/0WFWI6ii9cBeR7v607kV3J788iS7DAjVDdGpa5nObpINDIBYQN2AxGdXbxm
 z3pW3AItu+9OBqg4YmwDoLPzbarMZAAfVaOcKXvzLhLY1fLGRo62KKhGnRnIh1qMCchL
 Yx4icikUaeYWHSLwaklv7efa/AMIOwdcSGlR0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789127091; x=1789731891;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=nPakNwyBUrTKD3VhGX0wMLO7+pZjbIJcBRqTwK3EC6Q=;
 b=YZLl5IqiOZ2aLafJcD4Yxkr4JjWzKmOMLA8S1SREsW1asjckK/tKNf3mNF0kZQ7vtp
 5UCd53ca/fCjO0nsVvuNIlinsE3gw0q6I+Vd7rOl9DvACqn1ExY5qiylBu2vZUYMWzCS
 Upmtajqyw6slu6WbcuEGGzU2Bex7ZOSTRdkWE9FDIc/YZnbRUtTTx5gE1AYqebcbOOVS
 YG7QaigEbgSI7jyoFxhGFeQHKDDKSbDCdpdHG0UR9POKpYFMNdLjpULzusMJIwxkbzLw
 WZXBPdvqLbEzKDyNDAOLGdrC8NYJUEwEjKYP408A9Uc8Z4rgQmftS7Ej9ePQte1JK26Q
 bcHg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzgZ6wqIhrJOqD3wodl49Hpw4IsOdQmZYcmv4XfMrQ+4c6oCGcqB1QGyDUkj9BAYD28x5r2hNU=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++k1icIa7HOqJdgcCErC8J/ofekLQCd7BcThLUvOGl1X49BoOVJQ
 ZA1djcr1o0a0QAdezyf0eZQ2Az/bE7PXlu1qDDoV46OPGMkOxm6szjf9Hvn8HXG9FaF1gJky926
 bClCBbT2LVmXJREGYA6g5IINhf364c5WT+pPZXWHk
X-Gm-Gg: AYBFou3ys40WCY7MKDzve3buFP3k/sDMEnO1XMJ0woNwGICM8ynBR4G+Cwhtz67ATHz
 E4VgIVDo7XT0iphALHZA1g057eUKHB8DvwV4MaqZrrkTaiFpDV/DRUUmgdvR3UFNFlh75KKQSyD
 ++SpAGuMnovYQ7w96zz2Tt13H8cV8UQ4As9i1iddoESbx8SSFN1speckbh7CSa2NrDxJZ/siWJD
 RM3CwxEloiMyum9IaQXUsN4DOjvfh7Uw6IxDveSVIV4AnWZh3+QBllcP0ld7vJhYbra9uGL2ZtN
 m+T3172HzARNomMPCnjZZolkwx1CAe/RWu/r0VoilT5YiAAjea8dE5E=
X-Received: by 2002:a05:6402:2186:b0:6a9:b1e1:ad0 with SMTP id
 4fb4d7f45d1cf-6a9b56265d0mr1518423a12.14.1789127090943; Fri, 11 Sep 2026
 04:44:50 -0700 (PDT)
MIME-Version: 1.0
References: <20260829192119.2658328-1-visitorckw@gmail.com>
 <20260829192119.2658328-2-visitorckw@gmail.com>
In-Reply-To: <20260829192119.2658328-2-visitorckw@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 11 Sep 2026 05:43:18 -0600
X-Gm-Features: AcwNN1XiTo2UqEORlWy5L3fdYimCmMvHKLyrIKo2smvFdwTPWUYOkzOunqLJEPw
Message-ID: <CAFLszTh=Q=cLy8Z2u_JUeq623_=vhdQUj-YuN2Gk-+9402UP9g@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] net: 9p: Add 9P2000.L protocol support
To: visitorckw@gmail.com
Cc: trini@konsulko.com, tuomas.tynkkynen@iki.fi, bmeng.cn@gmail.com, 
 sjg@chromium.org, jerome.forissier@arm.com, jserv@ccns.ncku.edu.tw, 
 eleanor15x@gmail.com, marscheng@google.com, u-boot@lists.u-boot-project.org
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

On 2026-08-29T19:21:13, Kuan-Wei Chiu <visitorckw@gmail.com> wrote:
> net: 9p: Add 9P2000.L protocol support
>
> Introduce the core 9P network protocol client implementation.
>
> 9P is a network filesystem protocol originally developed for the
> Plan 9 operating system. Add the baseline 9P2000.L protocol handling,
> including message serialization, DM UCLASS_9P transport management,
> and basic transport operations.
>
> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
>
> include/9p.h           | 203 ++++++++++++++++++++++++
>  include/dm/uclass-id.h |   1 +
>  net/9p/Kconfig         |   5 +
>  net/9p/Makefile        |   5 +
>  net/9p/client.c        | 408 +++++++++++++++++++++++++++++++++++++++++++++++++
>  net/Kconfig            |   2 +
>  net/Makefile           |   1 +
>  7 files changed, 625 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
