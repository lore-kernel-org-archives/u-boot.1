Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9C1DC56208
	for <u-boot@archiver.kernel.org>; Thu,  6 Aug 2026 11:11:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9855680A6D;
	Thu,  6 Aug 2026 11:11:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kNhxu5vedDUB; Thu,  6 Aug 2026 11:11:15 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3509080A49
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786014675;
	bh=prtfY8yT7jW+EBMX7zBngI7FpWknNVjWwyluhVy1h7Q=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BbELUWgfUk7tc+xT5BqTdVVwMkcItOGQEvji6vjNCM1VvoX6rxfxBSzRJawi28GNt
	 QNyxkcek7ihpQTq5caaNjRbceubnOxp2HLWdJvfYU+Id3o8tyK7BwbJPTzyU+KcmIM
	 1FKRvVKViUodQtLd+8X6tQTGw3QtANG3GV1V07Gm4UOEmIAUbdIYwCYIEAJ59W+QOU
	 DDDCXtmI5RIIM5V98FTpW7w4424dwmWURRb3lkqYYmHmAxOJ6ojNBwlXEuH+Cuf9Uu
	 6kq4g1Jo6/S5EZCu/WMHyXhHU+gnc1WQ4RuVTLTzVG8Mogg9Cn8Ld7b6GrqDhZ/34z
	 rb2EnLVYMG8uw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3509080A49;
	Thu,  6 Aug 2026 11:11:15 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id B73F3282
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 11:11:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A973C40265
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 11:11:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0yz5qwR6ZNYX for <u-boot@lists.u-boot-project.org>;
 Thu,  6 Aug 2026 11:11:13 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::529; helo=mail-ed1-x529.google.com;
 envelope-from=jbx6244@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org BB8C040262
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BB8C040262
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BB8C040262
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 11:11:12 +0000 (UTC)
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-6a1541ea780so306612a12.1
 for <u-boot@lists.u-boot-project.org>; Thu, 06 Aug 2026 04:11:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786014671; x=1786619471;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:from:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=prtfY8yT7jW+EBMX7zBngI7FpWknNVjWwyluhVy1h7Q=;
 b=LVBt3kO1ZheLP+vwLqMUvMh5mFCegEgn2Yn4UhFT47DaQ6nmXTklbu7KWVYFQhBUn/
 khO2+RQ46qY67D1q1wszDXsWfeHO3SZb+FCosRIwy0aFpEkjvYQ2bwZ1v8t43BFtuLrK
 ZJASeau56EDbRTCcJ8aKIV3fFtk5qrS1KJavIzvKYAM6kGJzi276JmQEzRzjCpc7RJ5G
 15hqPZuOHAUZbGdVgwI5wk+YqT/ll3frRsgsuMiqQtUtjV0WYA8UHX+LYz6zt5LzpWoC
 B5zSegg6kiqt1Ue35Fufwz2A+IvPRrzfje7JkFubh0Kwl5be8YtTyk4kDclp3WUIXCpb
 1huA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpRWyAS/jf52xDHnZrBSVflLCnX6IRYtyyafToifaGBI9+0NGSeUB4E8KRMp/URvbKjGgrlLag=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YwuDyFDIlVP6fJyXN+66aoanqlYEL8qxGY963qTP8pfyF8zVqpo
 7NCGnLZgERA8kR/iTTZuLlN2RfUhkxBlSfhbNdJhU0JA0gzs0lGA+JTT
X-Gm-Gg: AR+sD12Rdl+WNRut/hUZQ69CNhSXi6tsM+HF5PTI9hSrybrPz+ymHEdNl1iKY1SQNT9
 qKzPqcwFulEK41eTBDiczceDZ81siUrKY/+ZqjKBOw6OU3KY3/1J3GFwxK9JWCzVkmODBmtRczG
 VZkJwXXV0DN9keznE8vCAyBJn3NLFqDOrG4yo/YfDEobAbLQrpZGtX5tXf/V/pQnQDb6S+zT2Sw
 fJZe0zFmbO/ljdK0vz6Z4kj+3jEN0G7tDwtp+kFVecvH9bEo3xEA1eJpqeT5vImPgjg6BMKbZhf
 F0AtQeMb5LjSNiOw1YiryebtPAz+izkLjQKiL2pUZO6UbZoHti0gU7AabCWx3/tNPOFA7agRjSr
 wOvQH9Ix65L2Q8mfO13JZgh7jQ3Blr6rUcBKnwr7eacq7eC8K1gr8Ao9E5rI2By/1OvMB2WNTVP
 qre0vUUWUtvs3vvYH4uqSWHFdC2YnVtwCiWsB66A0PBdk20C9TZ9jG8ikzHExOjM9afYTMGPD5E
 QLjbQM+5kxJ7XG9B4WEO2YCrGdq
X-Received: by 2002:a05:6402:529b:b0:69c:794d:4866 with SMTP id
 4fb4d7f45d1cf-6a14f29cb54mr3972515a12.4.1786014670356; 
 Thu, 06 Aug 2026 04:11:10 -0700 (PDT)
Received: from ?IPV6:2a02:a449:4071:0:32d0:42ff:fe10:6983?
 ([2a02:a449:4071:0:32d0:42ff:fe10:6983])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a1947d3048sm702765a12.9.2026.08.06.04.11.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Aug 2026 04:11:09 -0700 (PDT)
Message-ID: <61027ad5-678f-4598-8aa1-cba5e90c4e2f@gmail.com>
Date: Thu, 6 Aug 2026 13:11:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v5 3/9] rockchip: doc: remove TODO
To: u-boot@0leil.net
Cc: kever.yang@rock-chips.com, sjg@chromium.org, trini@konsulko.com,
 u-boot@lists.u-boot-project.org, eddie.cai.linux@gmail.com
References: <0ce61246-3191-4ce2-a7ea-8ab3c02cfe80@gmail.com>
Content-Language: en-US, ar-EG
In-Reply-To: <0ce61246-3191-4ce2-a7ea-8ab3c02cfe80@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786014671; x=1786619471;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:from:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=prtfY8yT7jW+EBMX7zBngI7FpWknNVjWwyluhVy1h7Q=;
 b=edLXG07ykyOzgTEbVEcXMk0b5yDVdAB8imAAMdvZ3eLu2hj/X8+z7G16ZASpi5lnsd
 zcFyYs3SjOx/JwMitDBYCS6ObjhEpW40rubTOsA+vWLTA2+yQ558MDSWs97Mfw/ChVh1
 xGFl2qbB3B4RJzZdBxhGpC4DbZ7AfHPVeYu/kYnjxTn/9bI6nrk2kJJTlnwv8+bKUsq5
 XhQ4szs7MaTsrjqPC9MFDWx4aRPibvK3gKkjtLRJaAfVskimCXDAq8iRcm44yRdVML2H
 YCH5zrL72Gf30+UMYxOj2npKbTLQ1Ec667PmsSVM0o0I0Vt7hP/holajWnKAGjzavFmq
 JFlw==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=edLXG07y
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

Don't try to guess the future consensus. And don't add
a TODO if you don't have the intent to send an immediate
follow up. Remove the TODO in a constantly changing document.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 doc/board/rockchip/rockchip.rst | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
index af6c08c46636..369dadbce53f 100644
--- a/doc/board/rockchip/rockchip.rst
+++ b/doc/board/rockchip/rockchip.rst
@@ -559,13 +559,6 @@ config-flash.ini:
         [OUTPUT]
         PATH=RK30xxLoader_uboot.bin
 
-TODO
-----
-
-- Add Rockchip idbloader image building
-- Add Rockchip TPL image building
-- Document SPI flash boot
-- Add missing SoC's with it boards list
 
 .. Jagan Teki <jagan@amarulasolutions.com>
 .. Wednesday 28 October 2020 06:47:26 PM IST
-- 
2.39.5

