Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A658C55165
	for <u-boot@archiver.kernel.org>; Thu, 30 Jul 2026 13:30:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 01AE040A69;
	Thu, 30 Jul 2026 13:30:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PcdDAh7N_QDX; Thu, 30 Jul 2026 13:29:58 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6B53840A57
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785418198;
	bh=GiRQU5XOXgPtu1+DB+dz6V/5Vu8p9q/LoSWwy44WB9Y=;
	h=Date:From:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=f+niFI+FENRiV1V5ITVuWkXdrvOMh2BN7XhyLZ1N/XX1KDvTv1uxbc15JQl/BQLyk
	 wCdG2dK5GczOTq1NP2wJXXBgRM2eXuAUKR4FzfRlTAGa7VT5HOT7Thja6UCzsjqckb
	 qLFzTgJXXcmwCPxHiitvdgjKPQPYj4SW+hyyI7ir0nXz4jzT4AL9YxwxQEPnLeuq73
	 TbAA0hl37rHy1MG141huE3WC4B7G+Mnq2BaAdL/s2S5U9N4R4QD5l1qhmHhLiBbEOk
	 4hq1ktR8Nj3HyZL6s8ZQ7S9CQZ2CaY/aq9/lqq0jTkYGDo67GhRiCCV0ktBryV6LT9
	 LuEltp1Ih97cA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6B53840A57;
	Thu, 30 Jul 2026 13:29:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id CFD0027C
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 13:29:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C230060895
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 13:29:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id F10cbqrx6awB for <u-boot@lists.u-boot-project.org>;
 Thu, 30 Jul 2026 13:29:56 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52f; helo=mail-ed1-x52f.google.com;
 envelope-from=jbx6244@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org DC0136085F
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DC0136085F
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DC0136085F
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 13:29:55 +0000 (UTC)
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-698aece3d7eso332930a12.1
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 06:29:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785418194; x=1786022994;
 h=content-transfer-encoding:content-type:content-language:cc:to
 :subject:from:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GiRQU5XOXgPtu1+DB+dz6V/5Vu8p9q/LoSWwy44WB9Y=;
 b=oL8KO94dY5TmImAERD9Xu7CqpXEgMPP6X43gmE5nng4yIOvT+oQAxiIdF8eScGtCqi
 S64F6baO8da1P+XwEdyWl8R+PsWxximqXn/4AlTwFof8vEW1cXATgLW6PP82UVofnwQd
 WP+vJFkVnSiBvLNx6Bh4Tdq0i5YDS7O0xZtM8v9zU1crA0XnqXQzbmxKJpLSq2w4gGUx
 SZW8zqmyFYOga5/Ivnr9wsfLfa0KBDO3hbaU0bMyI45+nFeKG4ozh+sKKmGLBkch0aoO
 a5wddFMt8pqgpPK1or5+ZeKqAUHK1+SFkhuu8/mBF2z5a5Bbfpp2SdFyiK6kJXV5Eo+c
 3vDw==
X-Forwarded-Encrypted: i=1;
 AHgh+RpwZ6SrwCyE764xNMt4EJI8/JexFQ/wxr9oisb+sneXzzrdci10sac8eaob6kLz/Fal27pFc0w=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YwmpI3j97tW77ymR20wpqixnLiji//JLV+zQ+0cT/uDV7bjDn39
 Kh9JNs/0k+qHx/AmDFZ6erx8a8t7bGSXhGMVjNWJM2jkZAEfX+fVOa1TlRSLwA==
X-Gm-Gg: AR+sD10ZwJYwCYEO2J7rS5Kvd0nua/yX69jZhJoQmFzKDLGv4V7xN+LR1D6KR1aHnqT
 Nu0foYxKxX6d1KiCF4cLiFpB00g4YjkNiqcV7d+b5oh0V6Y122uULM6MGGFs6CbI2MOV59F4OyF
 9E9ehK13Tdz8LR8nfg1NjURwkogHKIUyRRQ2cOF1QHYu7LK1trRpZg+0ZxVFPmogmB8pbpYv4pA
 29kd8zGBK/8DZczgqsEjzXSh/kxTRRmAMlyQL4pqIuYM+HUG90LGSjoXCQZCfpm40wVIBmb9ozb
 wrhaLR6iWmL/8BR9Kez50/mJFjipJMOh/rMYBIbeveGrK0Pr0jVXR5iNoFZEPMhUN52YoruOBas
 PF7WqMhDY8RbVdvDs36PSb5MqFl2s5mpV6DxYfBo0li+68NX7eLtGrGwo5pEO8B7SDQ+suxyM9x
 i9ElRlxJi6clGZo95mLaxHuJx/HE/+gI/H+dRnHvKKarIdBoQ6YBEqr0aiV/wcCenZHY6PJmaky
 GrM51XsK9/wZprcHlmGlslJypQFjSn+sqLuvA==
X-Received: by 2002:a05:6402:4349:b0:6a0:4e35:deaa with SMTP id
 4fb4d7f45d1cf-6a090d62d0amr194068a12.1.1785418193307; 
 Thu, 30 Jul 2026 06:29:53 -0700 (PDT)
Received: from ?IPV6:2a02:a449:4071:0:32d0:42ff:fe10:6983?
 ([2a02:a449:4071:0:32d0:42ff:fe10:6983])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a07d3a26aasm645399a12.28.2026.07.30.06.29.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Jul 2026 06:29:51 -0700 (PDT)
Message-ID: <5aed2a27-bd7d-4b71-a6c1-0b46b41f3462@gmail.com>
Date: Thu, 30 Jul 2026 15:29:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v3 00/12] doc: clean up README.rockchip
To: u-boot@0leil.net
Cc: kever.yang@rock-chips.com, sjg@chromium.org, trini@konsulko.com,
 u-boot@lists.u-boot-project.org, eddie.cai.linux@gmail.com
Content-Language: en-US, ar-EG
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785418194; x=1786022994;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:content-language:cc:to
 :subject:from:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=GiRQU5XOXgPtu1+DB+dz6V/5Vu8p9q/LoSWwy44WB9Y=;
 b=C9IcPVjjNkEiIbGfLk93wlZKt6fTr4epI4NUhdMc41JTrkr34g4Yz1THpXFUJtkheN
 EzFDe+fVjWw+R7FqqeGdOlvX+15zItxK+tmlB8eoL1cnyvjU1ECRCuUO7d+8SHV8u9Ea
 HcNzmyuTHNOiNZBl4WDPnfa+yudjQvvDqjZR1m3B2DlIrV7LDzduvx8AyEGbYe6hHRbQ
 hJvETSEEY1LMtVjMFyQwnLt1kKqEg8gb0PHf29UIfd+q0N+3LNjJmcgh/HHjBsLKYal3
 tzPJFuLfyPQbc8hjzjW4WTI95RTfqXBH4cGa0agNEZO9JJNqqaiMKdaWEXUVZiaDqd/z
 nykg==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=C9IcPVjj
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

The removal of README.rockchip is long over due.
Prepare and expand rockchip.rst with more info.
Move the still relavant parts from README.rockchip elsewhere.

Johan Jonker (12):
  rockchip: scripts: remove rkmux.py
  rockchip: doc: change TPL phrase
  rockchip: doc: add BootROM mode text
  rockchip: doc: remove TODO
  rockchip: doc: add more building instructions
  rockchip: doc: add more eMMC program examples
  rockchip: doc: add boot medium layout text
  rockchip: tools: add comment section to rksd.c
  rockchip: tools: add comment section to rkspi.c
  rockchip: tools: add comment section to rkimage.c
  rockchip: doc: rockusb: remove refer to README.rockchip
  rockchip: doc: remove README.rockchip

 MAINTAINERS                     |   1 -
 doc/README.rockchip             | 684 --------------------------------
 doc/README.rockusb              |   1 -
 doc/board/rockchip/rockchip.rst | 132 ++++--
 scripts/pylint.base             |   1 -
 tools/rkimage.c                 |   4 +-
 tools/rkmux.py                  | 218 ----------
 tools/rksd.c                    |  21 +-
 tools/rkspi.c                   |   6 +-
 9 files changed, 133 insertions(+), 935 deletions(-)
 delete mode 100644 doc/README.rockchip
 delete mode 100755 tools/rkmux.py

--
2.39.5

