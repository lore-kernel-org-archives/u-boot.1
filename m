Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6204BC88E53
	for <u-boot@archiver.kernel.org>; Fri, 11 Sep 2026 21:07:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7B9A6606BA;
	Fri, 11 Sep 2026 21:07:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Oyg3TykpGGVA; Fri, 11 Sep 2026 21:07:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org A6DB66064F
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789160822;
	b=AlsxkWmxY3rcpmvctEzH14ne/OdxWjH+N9egD7t5UW5BgBLNyj6ImB5rFXDO0aZZfTj6
	 uClabac3oNmp4VMb5i9f07zdNugpTDPhzUNT4aT1/S7SL1QXnL61M25KxZwBNuY3jEvab
	 ZA/Ke4GFnB1wQAh8qiHzNHHUeQhPiRPHFy3ISEzcb+mAesfaQIbR0fWbNBGpgWOF6CxLS
	 SipG9GUj3/ygrLy8wEWK+HyxYiF0KghLd6YlxF3VWwQ8Tz+wVkYZ/Y1e7GmnuM7BSjn/w
	 WukJPUjSW+grD0pyYoNlws55yQ8GTEHWSpuhSED/27HKsTRt6xw+geK6KdRU6SPkXkA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789160822;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=kcYGxEsAGYcHTlYSaRQ2r8+qCuNaBSrjZU0VEEa+Nz0=;
	b=gr71eYU9BKdLYgs6pEZTtwWlTeBXrQsJRUvIAvIUi/3pTS9d0nvkU10vO6lLOWL885di
	 ywrGMo+qV4/G1S857J66ue3QbZ1qt+tS5Im0yECAIlosegLT1KSVLy584k22Pg/4MzN4T
	 WtRGzLqkiXUuUwUvK93v5nA9v8JJgPH0SSoLWQ+YmOzZSxmjoiyYsAergUxlifM/xF/Ar
	 p/aEC+uqgDAbtBbarbilPBHowiu1sk3mEHKZz5XzfXFFV0SpR4QTeHZI5UuK19XhtheU8
	 z16luphF71VqA2vo/JbdArLwAMKMeWURPyt46b2UgMJWxhtZi48wKaE3cKXL/AWhnxA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789160822;
	bh=kcYGxEsAGYcHTlYSaRQ2r8+qCuNaBSrjZU0VEEa+Nz0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Wcn9yQmqiJtlPjht0ULs4KDkGUCbIeQiAGrCIF0kIeD2kyaGVEeY6CiL/KiM9GTDj
	 Kq018leI9YSrieiEHxiaVWmipI8BE9ToCjZhqZ7k8EbJ2vivDqoar6WVnKSbzdvnKN
	 vsngJlPMy0v4QEuaqMnhJ9HWFcNpyFDlVUqTTe2qW15hWyhMibNIwSoKfSO0R50SYe
	 IiQjf4FF7Qu/dIgJv3wErbGo8SO/HUxKtHFzt2sDAFbb+5BR4huSjp/EhU6+q1yqEO
	 dqmXROUJMqIRb+J7Qp46vPXnKCou296ayNTJZhQH3uiUekR7tmkluIwEQoBoLK4p76
	 EH89l5qENmbBA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A6DB66064F;
	Fri, 11 Sep 2026 21:07:02 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 83CFB32F
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 21:06:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6A2D9407CE
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 21:06:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hre5vh_yXk98 for <u-boot@lists.u-boot-project.org>;
 Fri, 11 Sep 2026 21:06:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org A854E407CD
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:32::4"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789160818;
 b=cW/7sg0tK9+C6p9yjftbqK+lgOCPOwneKeBwlSFCRdFoJ6g3R5ss+CgJpN3VjEF/E0Wx
 p2qUyNvevakingjWlnL/LH6HIfUqeBVVcEDiDhXywrz5wvaQtjDLcgJJlPQhpTOwHDczm
 8HWnRr63pcWJQcMwjjXegrZQvSme/Vr0ZGxV4V7tUyVKeuQuSD/KKVAtztRGY3xVjoJMD
 e23ar26KhW3Idvl7zEYBUIc8nVO4NSVCY+Hzcivb2Z2s9ajnlH+jSjNvenboK3zOdXU9v
 8Q8ENYZJ2BRptiBq8BazlFoNam05GzjM0QCMHydACocS4kY54DvyUKgG1ycLkFjlQOQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789160818;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer;
 bh=kcYGxEsAGYcHTlYSaRQ2r8+qCuNaBSrjZU0VEEa+Nz0=;
 b=OZcWAFwI+CkEk0RVsIhWEuCofVekcf0oSPps9sQknsXeawwzzEFuc2pjUdEKTrqmGIst
 DZYZ4sH9ow4ze4ALCLEPacqiKezv1InX7v47wBt6F9yV9sY8zaXbVzbgBCYIef8+PI3cm
 qirIu7BPff9OVruULZWBS9j6oZHPNFFqkq5jR7gLXAK6zlzBChKNk8G3PhZtOo1pXhELK
 Py49F/ONi/GsTw1Oy8zQJ15p7T49Zrgi1nn+3jq22IAAgP99fi0BPAunffMhUnbufTPyV
 dF7dtU5af8k3esLRH/ZZjlYvL4poEppfkctJNv4IVvBPdXpbX5oZF6H3OkGUH64ryyg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=b5NkicmU; 
 arc=none smtp.remote-ip="2607:f8b0:4864:32::4"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:32::4;
 helo=mail-oi2-x04.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=b5NkicmU
Received: from mail-oi2-x04.google.com (mail-oi2-x04.google.com
 [IPv6:2607:f8b0:4864:32::4])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A854E407CD
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 21:06:58 +0000 (UTC)
Received: by mail-oi2-x04.google.com with SMTP id
 5614622812f47-4b38a6e8c79so487343b6e.1
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 14:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1789160817; x=1789765617;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kcYGxEsAGYcHTlYSaRQ2r8+qCuNaBSrjZU0VEEa+Nz0=;
 b=b5NkicmU+aTiGJPCYO+S94zOYr56FA+G3UMvW3wNhWMKYZNfJK63Ez8zebr2BWbauU
 Oa9wf5LOFqbHibQAnW/Zsqjeu7GucW+hiz0Ae01IuYeQYUtX3qFign5C70s2YJkAbhZe
 zwwxR66RE0RRIuKUatVXY1iC6z+pzeQNU8T24=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789160817; x=1789765617;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=kcYGxEsAGYcHTlYSaRQ2r8+qCuNaBSrjZU0VEEa+Nz0=;
 b=iCOTJh219SbRk7XDktbg71hbszYQ9eo6dtBc0T3aigBdtibpU9iLc9xBh/i++mEx9d
 tXGbgYUNF2GM7GU90oM6TgwF/eEl15NE6zGJ6TmEJpL/vbJ8Xe5T/WbHTf+/26b00y2u
 czcaGiK+rx+d4qRKIjRJ4VwblVdEImCWLlCo2qbR3rEKQv995+i534r0kY2+/by82KhS
 iFtZUT2q817gvouwctbDjfC83I5wZphlI8bVsvkaiL4odSNb4hFXYnFc6ZxZyzEa1k8v
 yk5UoC5EboqWIfQn5FSpyleb4VBeH1QmGwDPoMFfXeGKIWUc89ymK2c5bj/6izGNECbs
 py/g==
X-Gm-Message-State: AFuF++npUCM7/KLDhnzYQoR+jSUIzz/xMzDE1iR1glF8HliqWQR4W9eu
 KY2iPYthumhUb1vr6pPCfcKf84NBaTzcR1qKnlQRxHi3Ll7IdYRGthu1c1AgcbMNrAFsVKzmAYW
 PLTSLex//gd/ffuA=
X-Gm-Gg: AYBFou2Uj/hbYBKsDZUOib0C1j9WzHgO1XVOB/RzSfIV480uEDyQUt9vgWov3IBbEzh
 eqarVUzrn7ZwF7n6iCb7y2DwMzXumXdkUUmTiA+iBZT95wCjad3WHz8uEC7zagHfMb1iD813AGB
 O7egtg6GIosLdcn/LWE1gxbhczYSOrzCkAtknIe8iTUfOxgaCfnTuQGodvC2oWKJoFfYj5qJ9cf
 +Jg8WUKYtXzXGMrrlxZubGZLwSOpaZBwwlvcMR58uJ/Jm+EwqALEEknuvuFF/4WKh/+CeJ3cRtX
 fPVxuBQbENHKjctgWn32BZF8GkWphtHTLxJ8QDXszgT5k/ijLszRvcPyguhzaANKJJGIrC0DNfg
 O2mY9r89DTGWzt7N9dKCCoWIACmflZ/xG++mNhcTO/XysVmBCYxBlRUc5bBBypHC6jKpQXnzR3m
 4xaaeYTt7RRaDsDpQvfgzKneAYxVecP+W4CTfUrWMRcwZpkFaBvQlMTGkZ1eGp14VHDuM8YtB1i
 ue5BOuNaPOPVD6Lv11exjoeKibuFmjMdEzMC5gyndfHPAhEYeylrmfvdDmHvfiqDjEVKfe8E7MR
 Y47kaZ/caiZEwHgDii4=
X-Received: by 2002:a05:6808:6d97:b0:4b5:5bfd:518f with SMTP id
 5614622812f47-4c31b5bf597mr5283401b6e.21.1789160817014; 
 Fri, 11 Sep 2026 14:06:57 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4c32bde3858sm3197723b6e.0.2026.09.11.14.06.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 14:06:56 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, Jens Wiklander <jenswi@kernel.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
In-Reply-To: <20260908125438.2720215-1-jens.wiklander@linaro.org>
References: <20260908125438.2720215-1-jens.wiklander@linaro.org>
Subject: Re: [PATCH] MAINTAINERS: tee: update Jens Wiklander's email
 address
Message-Id: <178916081618.3818440.13099870002280146142.b4-ty@konsulko.com>
Date: Fri, 11 Sep 2026 15:06:56 -0600
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

On Tue, 08 Sep 2026 14:54:33 +0200, Jens Wiklander wrote:

> Switch to my kernel.org address in the maintainers file.
> 
> 

Applied to u-boot/main, thanks!

[1/1] MAINTAINERS: tee: update Jens Wiklander's email address
      commit: a44f46af0aa17e48572e0d46c0d082886ee353c3
-- 
Tom


