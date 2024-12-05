Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85172E7716E
	for <u-boot@archiver.kernel.org>; Thu,  5 Dec 2024 23:55:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BDFF988E18;
	Fri,  6 Dec 2024 00:55:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="FYNbMBX1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 199508953A; Fri,  6 Dec 2024 00:55:32 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 18C7888E18
 for <u-boot@lists.denx.de>; Fri,  6 Dec 2024 00:55:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1733442929; x=1734047729; i=xypron.glpk@gmx.de;
 bh=pL7AKaivHNiRHgwjBeSWXD2iix6ruBePhxMERUPQYg8=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
 Subject:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=FYNbMBX1D3+60EkOlF6uP4N15pu/63EOvA7RV+/7tR1uHPSIxhDLAgWOJwK9M13i
 Sokgizup1e3UzoFG2q9OdGYdesPKRSwN6Hjgpe58y6DT8Stn2qSqxSlfvghSwQlGj
 RvhxL76RneQPH+qOH88DBx3sNP/MuuOlzsBQdfKxJQtsuEY3EVbp4rZdN8Tf+YURz
 oQ8bL7HrmBmRXsnGP1hvYwQ9W36RcBMvTA+5wQ5IP3RfKv8fBt7i0rI5V7Wlcdn8S
 xW1zOT3M7rOB1dY1qog7BNh2bcAQogEzHToN4o4fyD36D6p7FW2PJJ3NxqviN56hf
 wAK3jh6ZBs+EvNdl+A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.143.105] ([46.114.111.9]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MYeMt-1t5tOl3tVj-00WVDM; Fri, 06
 Dec 2024 00:55:29 +0100
Message-ID: <c049545f-be40-494c-9b6b-3d8b9f3559bc@gmx.de>
Date: Fri, 6 Dec 2024 00:55:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Mismatch between wget online help and accepted syntax
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:Ib2syErxrMS04UiTbcaNOYfO5SAiPjwndNvhreB3GCE9532uJKE
 ynAehevj8aP/oEiYRrj/D8jtNzSpD7LcOexgp4TAiwoUpYvWK64bz/4sSrXdPhaJrkzUR97
 HTIpGgboETnmuSWJQoR3wavsIi6OtCDc7Of3UrLxZL/sQJV3YuJhxyJK2GBgei6g68D8caw
 GizpxSyfqNB2FgEbCIWnw==
UI-OutboundReport: notjunk:1;M01:P0:WQ02kZCRNv4=;6GeZCVrRscMMFH4StlWA8s6hzk/
 We2+GsZVwXyqM2arLHXvec0wofAS+AebmMteRK9mBIuGCSfG3r7sClxVF13tkzy5o/3RHpNGw
 DIimuOfs7qci/d78OMPpyeP1qTATpFBvKkOzdU9nbFLkr062AI5VBy3ZAYIgkqGZM/G3sW0Sc
 SR5xiNYBxzRAk4ddZl4n64c1IScc0HN0/Cr4aWJfJreDTbdz/871XYBeeuWnqa6Y2st5Z/KLa
 ULbsYc9ujC3V0IkumDUR4gUqtFSR/ci7pOvp/5K+ZVusstfOm/ZpBaeAHdVXiacZa8m+xroCz
 /jzKTVYZyb4Yca8dK19aTs42yXoY391ihmSbNDTy0EF3FBKriASWQXikxhS71G5RJKhzd3Fg7
 ju1hxR0b/srXo+2V79X/blEaUViGQXqKaHdwxiS43i8ZmNzX8DM5fW9s2+Y2z9gxIhzRAsTu0
 qlEj0RBS19AzUUeMyRLKJuyT40biY8MTvRnOg9iZOIaaKm6h+wLlGr5tKAVLGpuorI0m+yxwd
 nYB5ApXfjysWCJzRTrpDFoasW/46QSB8A7WWhuluOBNCQ0YRSb4AnvP/nch/OvxSoInt1w99Z
 lKIy32qUEsegqGZsjqiGJO3DaFjxYc81UtXXvtF0GTjtID3sTqO94Om4jBp+zudN8P4L9xGIM
 eKqRpfO6UKmIHyT+Gi6Tl5rj4+NneokEHaiJ8DIrVZYrJcM87iGFGetoyKZEhHKhBdIQLA7MF
 rBEUzu9I1ADpta70EOHxDqmk+xt8/kiwF3nst5IYD1mBuYsdGQQqI3bZUUbyS6tjsvIrdg1Gp
 5m+waRdSxvvzDcq51dWLrsXiutK3rs16bvYloRwLrDAFz6pW1iriFiw/oL68RG58gSFK8vFNP
 cvMmNJtOKEoa9sbrB2Lb3TrcPX9LqeStttd/VE4LhA+1qc6/ZQzzmxwGe0kwcCV7MrRY4y/x+
 GkmuUNdQYIRiP74B6gr1sFQkStIWUwiWYr2epbyDpqdB3jCpgQF2z2M2Fip1iaaKXT7ak++8I
 wbpv/LBoaKdN7R2n+6Sa/9PlV83BYTAX4/Zal+R6HizOy71wiOt7FDOPzH/QdBHk6IUMG9VvR
 DPLKedbDLECxXyqXf8Kt0RkpIrnU3V
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hello Jerome,

origin/next qemu-riscv64_smode_defconfig with HTTPS enabled showed me:

=> wget 192.168.103.3:/hweb/arm64/helloworld.efi
invalid uri, no file path
Invalid URL. Use http(s)://
=> help wget
wget - boot image via network using HTTP/HTTPS protocol

Usage:
wget [loadAddress] url
wget [loadAddress] [host:]path

Here the longtext help is not consistent with the implementation.

Best regards

Heinrich
