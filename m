Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A46CCC79F82
	for <u-boot@archiver.kernel.org>; Fri,  4 Sep 2026 13:08:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C91D360C00;
	Fri,  4 Sep 2026 13:08:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ixS1DfSXWD5I; Fri,  4 Sep 2026 13:08:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org A862E60BEC
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788527298;
	b=WE7YISha0XHL1bON2K5LeD435z00EYBPEir3BN/D/sEgfGUH8FJ1lyKxYYjOnQsQSBN3
	 NmPO+TX7OwhkCDUWFk08JU0aJSvrN6s0QYqVTAWcallSAFTHGTytCEdzaJFAI6yQsW+ts
	 LRiXZ8gS1ldqLv4z7STJLp7ShhpJQLK73ZUGmagRwCd4uaoEcDEI+2PBdOjJ/WMKQttsQ
	 ZxuW1voi1E6SM1YMAGwgyV1Ip/rRosCQK6d83yXhCA/o1E9glhHYk4s1QhC98kl9+tmkm
	 H3FNBp7slKI9s2dLyPshwCJDcdGVJD+XQwbH/fLDQ2I8fGStk/rw0x+ArlVYFRkkB/w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788527298;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:From:
	 To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:X-HM-Tid:X-HM-MType:
	 X-HM-Spam-Status:X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=tHWC1DpRAEywLwlyo2E2pfi9VnJqbU42vL+GeccAh7o=;
	b=GzmgElRZFrvwaQOZizGPCnFzhYdknFPgp/NcS/zgsFyqkTo43uao9unKXA97rCGlw9IQ
	 24Ti0lqFZb2AUvkU5M2lMW1yhT6fZOsy+lW17CnBnniraWHU0Sx8KmiUNtpgZRwKEISNH
	 hP0lCrWp14yrMyfkLrjqzbEeniPRxO7s/7MDSElQK8Mvc9UydP1fyki+x3SNYfV6thJdz
	 6eVyYzhZCgQguuoEsUbqqAesuQuKp3f9AP4vsIATRT2ROCW9WYphZqJLIio+gyrqCRgoR
	 O/0dDSRIEYzoErYDQi/20bd81Sl5zd/3cxHcHCG3PZT/OWtw2cmwR2PqoAzvsGpr24g==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788527298;
	bh=tHWC1DpRAEywLwlyo2E2pfi9VnJqbU42vL+GeccAh7o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qpOvHETu80jEhcLVMy5CdjGPZUadiBHZwKGynhtHK/fI+SVy8VeNBm2H/e29nISPr
	 ewSxYmaVEqx/WqdbumBkoirEWTXpL7CBlw4SIalAtXB93Bb6oGm3O6nGTa7BeWNygX
	 WQfTGf+MQhMad/QZs52cVkD6AQHH/0VzSYIlexQjY/5bDbzGONbA1rDMNQX7GCo2pK
	 fwuj/4d4ptX9Pxleu/tP7MpW47Yg1OzCZGeRNaQ/y15wqmNswinbLPQqIaLYcaEcrK
	 /RXaNX7HD8bDxj6gqCMSie1WDWHmGAd/yUlXqJmwfO0V4kjlFlKOavXl+zP9uNlN0n
	 ribNzRY9gYnxg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A862E60BEC;
	Fri,  4 Sep 2026 13:08:18 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 141C010E
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 06:50:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1190840A54
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 06:50:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id U-5uKfb2EFAd for <u-boot@lists.u-boot-project.org>;
 Fri,  4 Sep 2026 06:50:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 3C8F340A3D
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=45.254.49.198
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788504630;
 b=eEPnde7g0/AZ3PyqzO0roDysRs0KZq76A31pRdbJBmjVrNk8uVt7tMv7nTEk9ps/nJTe
 7pJAaQQqBi554irDzRCU2wKh/9s5Lp6GJ3x8SKlaXhNPbUuibX/knG/MlTq7mIWoasIaS
 sFw791ITuBWBmiF/PdC0FSS61ATXFuclmhrqCRql1PxdbWLoLBvvjrQWZIfb70KXiJfVM
 QTDBgxl8dz3pCqXUMblmklVhAFrhdexqQrh0vYa6Ue6iSfHr9YyOuiWhrcG+9hiG6owzI
 7z/KtXDolvOj0OYODzHjQCWpvnHYku/BAv+llucmBnzaG42umuB2CEytsEdtvrhWn1A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788504630;
 h=Received-SPF:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
 X-HM-Tid:X-HM-MType:X-HM-Spam-Status;
 bh=tHWC1DpRAEywLwlyo2E2pfi9VnJqbU42vL+GeccAh7o=;
 b=UYCSGki5606E0R9xl5ec6S7PI6x7nBS8mfLldEGGJJFXSR/5e0GB8gLYhNSJVuMLBFwn
 ZPMR0bNLZDK8itQS5/GGqhASDENkt05GBfqJRWCQd7Sj7QfNQDiKrBfdCn3TS/uYYemXd
 kp+0XrkW7TtYfyVWb6sqhRkL9ekuwSitqwLxUnOdeEijygPfEykIUeyyVmH0d5Rr1Ag0z
 EPUqaywKrYEh9ShXafecjlVulcULJpIdXfaGBj6Ltg/ZSkDL7v9oSG8+1McDjR6hAwHps
 TW94JFAivOfAqBQ4FP+zA2gnslTmawXfYjtY7xhhiK5CRoCM4Juc0AD7zm5guv2KC2w==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=jmu.edu.cn; 
 arc=none smtp.remote-ip=45.254.49.198
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=45.254.49.198;
 helo=mail-m49198.qiye.163.com; envelope-from=amadeus@jmu.edu.cn;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com
 [45.254.49.198])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3C8F340A3D
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 06:50:28 +0000 (UTC)
Received: from Vostro-3710.. (unknown [14.220.232.127])
 by smtp.qiye.163.com (Hmail) with ESMTP id 4c8634bae;
 Fri, 4 Sep 2026 14:50:21 +0800 (GMT+08:00)
From: Chukun Pan <amadeus@jmu.edu.cn>
To: jonas@kwiboo.se
Cc: amadeus@jmu.edu.cn, ilias.apalodimas@linaro.org, kever.yang@rock-chips.com,
 sjg@chromium.org, trini@konsulko.com, u-boot@0leil.net,
 u-boot@lists.u-boot-project.org
Subject: Re: [PATCH 2/2] board: rockchip: add HINLINK H28K
Date: Fri,  4 Sep 2026 14:50:10 +0800
Message-Id: <20260904065010.798640-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <3c2bcbaa-689b-42e3-8df1-0caed73c2505@kwiboo.se>
References: <3c2bcbaa-689b-42e3-8df1-0caed73c2505@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa06b2ec1d903a2kunme9f202cd2e86a
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZSENMVkhOGh5KTh5PSBgZH1YeHw
 5VEwETFhoSFyQUDg9ZV1kYEgtZQVlKT1VJSUtVSUhJVUpJTFlXWRYaDxIVHRRZQVlPS0hVQkJJTk
 tVSktLVUpCS0JZBg++
X-Mailman-Approved-At: Fri, 04 Sep 2026 13:08:18 +0000
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

Hi,

> USB OTG port is not enabled in DT, so CMD_ROCKUSB and CMD_USB_MASS_STORAGE
> may not be needed unless there is pending DT updates that will enable
> use of USB OTG port.

> The DWC3 node is not enabled in DT, so USB_XHCI_HCD, USB_DWC3 and 
> USB_DWC3_GENERIC may not be needed unless there is pending DT updates
> that will enable use of the OTG port.

> Only the USB HOST port is enabled in DT, do we need these USB gadget
> related Kconfig options?

I removed the USB OTG / DWC3 / GADGET options.

> clock-names is not included in this lists for new boards, please drop
> clock-names form the list of properties to be removed from SPL.

Removed clock-names from CONFIG_OF_SPL_REMOVE_PROPS.

> The combphy seems to be used for PCIe in the DT, maybe we should enable
> following Kconfig options:

> CONFIG_PCI=y
> CONFIG_PCIE_DW_ROCKCHIP=y
> CONFIG_CMD_PCI=y

> along with correct PCIe Ethernet driver.

I added these and enabled CONFIG_RTL8169, but it doesn't seem
to be working.

Thanks,
Chukun
