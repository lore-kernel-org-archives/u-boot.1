Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AFE2C53200
	for <u-boot@archiver.kernel.org>; Wed, 29 Jul 2026 13:40:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 949DF40B0D;
	Wed, 29 Jul 2026 13:40:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lhWxmRXy7iy0; Wed, 29 Jul 2026 13:40:22 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C214240B03
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785332422;
	bh=+lqUMaElO80jZ6+lPLqxzKYGC6VNkk5BtICmud2eVro=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=w08EM0Vqyt7AycMIwTgd7etUwd0v5Y09s51UteJ9CdA8NdG9US/OkBN9hEsUhLVyC
	 pxGKqP8T8wrxk5Py+0nz+xXQvi3cD9qGYhv1/EwD+uDNtbW8aQE/gL/0zFFWsIq7lg
	 kfhGTC0vyoXrePAEXLoJcJsh8HpGt1eu1lzAuKeGrIlGNxmzUDmhEfh6xag4WIca0G
	 31oIA7fjMFUsWMnNqkSdJ3uFyWS8PoHyPwj7l2ls3sy22yDLPbjxqT5oM4gkylNoCp
	 GDo1FVYSYxmuAtcSRLVu3/vQ/2nieKvW+OExhItML00NA0JGxFUIK7hI6HILJqaRES
	 FHIpIUjFX7H6Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C214240B03;
	Wed, 29 Jul 2026 13:40:22 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 4C5EC194
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 13:40:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3DE0F40267
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 13:40:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TAY5ztEeATYD for <u-boot@lists.u-boot-project.org>;
 Wed, 29 Jul 2026 13:40:20 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62e; helo=mail-ej1-x62e.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 4892140074
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4892140074
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4892140074
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 13:40:20 +0000 (UTC)
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-c197e7e4e94so163022766b.2
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 06:40:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785332418; cv=none;
 d=google.com; s=arc-20260327;
 b=C5zmPajcOaqIypx7BadMI83Pk2enRzAmPqOytN+EMCI4Fh2MqwlwUKQo6yfzKoRUA3
 x8ChAarf28STTMhkvr7X1nkQy36RCBrjNTe1p/29aSoaVZmpbYV70rmv2Rqr4mR8wDVt
 okNQ+MIjEhTgQSJf6tIxnuq7qpwbzGu3KEaKWQe9G/AxFszXUSJryctiS3SugecjKgDD
 eJz6o97rw67r1ap2lIu5b4jH4/38uUsf/dlJjLGQM5vOCO0pC1fxQPhW43YC7loyI9YF
 a4SliTcjVfHAyZzolIuaGYfZQsSTTuHY36oVcEZDWbqBOoK/HYc0CuhLJ2ZadBR08Svn
 NEWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=+lqUMaElO80jZ6+lPLqxzKYGC6VNkk5BtICmud2eVro=;
 fh=bHXsLXH0mlNUrLRanskZbIyubYUoA6z721vzsjMwAUc=;
 b=PDlFnWm4G0oLuqf7FoljH8qJktpjlyMuRvlT9XXmJhNPDA7G4J5tIa4UErFdCy0uNr
 TA3SaVlS8uP8PVFlv5W6z3QN2Us9jejqAZrnN+yjkGfZQPp2JV8SO+GuiOs1aTFqw7yR
 4zXYHD61lBcAfZy+DP+wyltT0GntX/qEC1DSoD7rSZv87XoixiDSBtVPzQkhAFECPezJ
 BUwSCzhRmV3PX5x4obALC3xtjXbzAPYJJr1Br0zfmHebjPa2t9aZJ3a9WKW7qett9JFN
 mHVln0bFx4X6oYyHukSiTIBh81LpRWYEJTLHpLLRwQgMmWU1QDLIuNUXNIBfFN7X12uX
 9nMA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785332418; x=1785937218;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=+lqUMaElO80jZ6+lPLqxzKYGC6VNkk5BtICmud2eVro=;
 b=fn+nlk97PELGEC+hMwxfnP1T81nTd56dRS7CQx7OsZtN+dGtzbeUYi5hy7Ozk81G/V
 BVD068KSNQQZZZxyOcmkitv9AvjwO7j8Uqu3sF3upT35GsyYeO/2X/MzY10p1iDiVBty
 GCQXUoXLf2GrY7fmeUZGxBu9LK/il0mmvesNfov+Z8qSdk6oDqARWavpdiUmKk5cs4gB
 zHKs/zD/EV/YDMhsczWu8c6HOFlKWeN8MV4Q+atL/wVlQxS9KDyqEnHk5gpupWGKSGHV
 DAEZ5MO6YjqOdFOEYE4th8yNu3w5tCfEt714uNiJyr1XNP5Cpf2HOSFG1chEDlHMNOpj
 3hbA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq3EBucKojkwgSMbhPsmhJa8weplpX1i6B4ZzU5aaw+UkrlF74J+sYMJGAwvVdvD4/3QLnXxdo=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yy3GGDv0+nvyujj2uonA5sKbG05MflevSErmT25pxVqJlljdMQm
 lk/+VgnWLBx78/wjan4Kt9m6lwe9qLADIQTRAD4NvOnD3GTavyIAIqHM3K8T1N50j3B4a1bbnbZ
 CCB4aAoBpH3/4B7Po9Nt2f3+zvYlrdFN/gINPKzIV
X-Gm-Gg: AR+sD13dYbv4tLlwXdlqEl+JkwykTtzIKkh2MItaU3hoebalqCaHMh7cCCE2nvQ31cq
 AxdghC1whEuHjXJDDiDDDyIlKVAxjuSTj26wEfnhJqmdKoS+pUQhh3JLTgqQIjf4NamSCcJ8VE7
 jsimOON8NiZjN2pjhP09chZYO8ZCy06gbSlDUiX41uCJ2NIs+FBJsEaGQNrwXada9BajyuqwCtW
 uEu5fNVN6vTANZojwDXJsgGSNXQWg5MQ21vyz/5oiNjwYwSFmPw3eepUu3zrnE69OWK7Zx6MsmI
 pJKNfZcX8ZQlQa7VrnVKrAtYGZcKhxDzTErC2jaoEFw=
X-Received: by 2002:a17:907:9616:b0:c16:9edc:612e with SMTP id
 a640c23a62f3a-c1f71e88c37mr372760966b.3.1785332418047; Wed, 29 Jul 2026
 06:40:18 -0700 (PDT)
MIME-Version: 1.0
References: <734d54aa-6523-4c2b-ba3a-a51b063a340e@gmail.com>
 <f7ed1756-6018-4b11-8170-7e6b363295b3@gmail.com>
In-Reply-To: <f7ed1756-6018-4b11-8170-7e6b363295b3@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 29 Jul 2026 07:40:05 -0600
X-Gm-Features: AUfX_mzk_0sAiLB1iskYuZXlkC9pzZ5OM4Pgt5Nr992dVWQ-n34GH594ytCZ4uw
Message-ID: <CAFLszTg_fik=unDGthk4DKGQPtpRiXce6qzfmfm2ZTFfK6qy7w@mail.gmail.com>
Subject: Re: [PATCH v2 01/11] rockchip: scripts: remove rkmux.py
To: jbx6244@gmail.com
Cc: u-boot@0leil.net, kever.yang@rock-chips.com, sjg@chromium.org, 
 trini@konsulko.com, u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1785332418; x=1785937218;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+lqUMaElO80jZ6+lPLqxzKYGC6VNkk5BtICmud2eVro=;
 b=mx+e0iUOs1PGHXNRxJj+ctPaHIGVJr/zdAi7/gQnUQwZrakpM0ginF/w2xR13YWOE5
 Z9BPITLJYhV7ihSrVU+Spk5ZBBlQpf8Cb9XUELBBD22btmcA1wkTtYXbchMXHH33V8rz
 bLr/FBBvzwoLYq9dRsKNiwcUvca9hck8FfBEU=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=mx+e0iUO
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

On 2026-07-28T06:51:38, Johan Jonker <jbx6244@gmail.com> wrote:
> rockchip: scripts: remove rkmux.py
>
> It's not U-Boot's core business to host a script
> to create enums from datasheets where it's unknown
> that it has ever been used for any Rockchip SoCs sold
> after rk3288. We don't need it to compile, so remove this
> relict from the past.
>
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
>
> doc/README.rockchip |   7 --
>  scripts/pylint.base |   1 -
>  tools/rkmux.py      | 218 ----------------------------------------------------
>  3 files changed, 226 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
