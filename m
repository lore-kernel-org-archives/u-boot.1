Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31913C88E4C
	for <u-boot@archiver.kernel.org>; Fri, 11 Sep 2026 10:09:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6F8F181114;
	Fri, 11 Sep 2026 10:09:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VGc41Ml5jcVS; Fri, 11 Sep 2026 10:08:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 009B481206
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789121339;
	b=O+1vLB9ScxBA8cktIc2QJrprrr+ac8DqYoQN4w/SgwZZC2Z1l1DbscAZa3Is7ibNCq2Q
	 HTCBjMhWn22IyLQsnxvo8FXlWs0yMoCZDui4J36oH96l2mt805aBSN9dBQ1zlaALHvSE8
	 y0Y/B5kiddt55Ha3Wv1MVuwAra6CyHSq5APCcesmHnJL547gxMK4vu9HWjWGzadt0l1iU
	 25d53h94p2AFJ0jTmIx71OntlqPgzvJxwNqI03BNoIUv6BdW1myMEqMWic7lj2+YXOU8T
	 p4tgaAJKNtefPB4faUNxIp8EhhH5iVERZz2uzIh9xu5KWTJ/HD//ZCb10rIeBLhbnOQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789121339;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=GRsjkUCBRCK0XqK5EykZpEqgmM36DhCdGEVvbfq3xnw=;
	b=s52QoCwsxe1htnTPJKV7IlRRctRJDcKSf1q6PRy/6gaHUw5UvzCN3jFcqwg4T3UXYW8W
	 CV0vdC8598hROeeK6cvzjg8dqIvUkbJq4PmbtTftSiAZ+u1fLjxgcHTcU6t4DYxVsG6jL
	 jOKRgWddstK2A+O5QUP3O0wJYMJ7nTIdIOeb3ctH3goc9/ZH9hpebht0jp2ewAFKQOHKk
	 vMskL7baxA6qXZ4n5bbP2RuKlBLKcLutV3uY6YunINTSBVq9zilapn4XWEfbz/0/EdBfS
	 /y1nIJ4w3nAkvX1c7OMOO85Dh5LijGLbPkHTubj/llxnT3JpSYXlVEW/k4wLAJKhldA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789121339;
	bh=GRsjkUCBRCK0XqK5EykZpEqgmM36DhCdGEVvbfq3xnw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yDZUq/kl7WtN+V82KQEqgVD00s8AV/wC0dkrUKlBif2pHizh/y55BHyv2L2uus9qw
	 CJFefImSgtvCZOR79p+SeuB5FWudca8yjslS3TpMloM1tkgTKQg2kVMMH/3iTyt/3O
	 aeMp4guU+iOJUEim1Q+0ebU4PUB7elbhU6xW7UZjo/HFN10r1cWBijWr4IMt/GEyPX
	 zwqVfdacFaN+SQC3L0Heid4jJm4x1kl2qRYtpjRqrwyg994RkhKiWx8Q7a0jv4yva1
	 RWzlHK8zpH4Ii6q8NnKWZGvzjRqj2tKL933oHQ272XpRbRsZq14zhc93QOIL9tFpaN
	 mIsEg31QGr9CQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 009B481206;
	Fri, 11 Sep 2026 10:08:58 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 3CFC829B
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 10:08:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 23C5B40064
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 10:08:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 72_o80yf8mlQ for <u-boot@lists.u-boot-project.org>;
 Fri, 11 Sep 2026 10:08:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 02210403BB
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:30::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789121335;
 b=pryp96EYGl0LpHveTHrBpw4p4jvJXZTGiPSlvL7Hjm+p+pkYGvAQsssywsOuaE5fHd47
 RzAIG1sQrsLbjlTAZ1WxEzKgD5pAdlwVw3nsKzfIoN3d6YiRDMyJJSYdACyM8vPHch+uK
 sl3tUeOkoxYkwv3Awl8PX1/g9Vyk2BKsZ/3brYxr8nxpkDXX1CRd4pY3qBp8IaJsWL3EA
 /Mv+jrnDD+BGJweDTM+xS6mnAAtn9gRPSLjPhHBXx9RFcK7Ku4CLQTXYkVknjUj5D2HOb
 EbdDvtcKuMSPXxOTE8nP+zNwWz4N211yY2HOPX8xaOItAruJbaYbXPVHCDNlYCHXliw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789121335;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer;
 bh=GRsjkUCBRCK0XqK5EykZpEqgmM36DhCdGEVvbfq3xnw=;
 b=YOA4ww51ZHrv565XMbiGTOyj1as9AVY65BKqxzQq/bVIFkiuyyf5ymwot2OOEAolRzA9
 d0HMkH2uHWQFHMc34477S/xvnwwlGxy+76FPbsoepsDh3Q/rgMsqA28ivx1vnjC2Cn5mp
 2vcw9XMdMuIxrsMTjH8VRhcx06cFCeBdxh5y+E/c22RocZo0u0iJrenqpGcchpvfbJkCy
 3IdnAtw/Hd1icwlSsVeaycFQxZbCZz8XLSqS2SBQLoh2UCi3/pP9aHxDTVpdXbNIZQCyx
 dqlSLa4wUF+5aFx3iQClKiWWiwVSvXf+HZ6SGCVsY6UdAm44OoFZEQW6ijNroW4c48g==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=linaro.org; 
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=v10Mlyh1; 
 arc=none smtp.remote-ip="2a00:1450:4864:30::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:30::10; helo=mail-wr2-x10.google.com;
 envelope-from=neil.armstrong@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=v10Mlyh1
Received: from mail-wr2-x10.google.com (mail-wr2-x10.google.com
 [IPv6:2a00:1450:4864:30::10])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 02210403BB
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 10:08:54 +0000 (UTC)
Received: by mail-wr2-x10.google.com with SMTP id
 ffacd0b85a97d-485b1d2874aso508954f8f.1
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 03:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789121332; x=1789726132;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GRsjkUCBRCK0XqK5EykZpEqgmM36DhCdGEVvbfq3xnw=;
 b=v10Mlyh107SWLwxNCS8vME5pFolMcyvjrKFOEg92UTxF4F/D0D+rz4yCcEqFInXDM/
 f2SNoiYm7ogM+6z24ckwoRdKBusw1KWevlRh8FEw9V/Bw84m3rcveLAWng9H6vuPuBLx
 DlonWwoJttFf+87SJRKM6guScwaG/0hgeYAB3utujqOssap+wIq+KWKdh8S7dMPbIKYR
 P9YeeyU8B3SpW5unVqdmlxXwhT6VuT0sTURxqzsb+1jLnlPOYGjspVSWOSXjQTSXi3kP
 /4HV6VYJJ3/1Qto7rnG92X+183reZyr0LlbTjFhOq6oAdvSGmnBz8SEwHG7MP3m/4zLD
 zglw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789121332; x=1789726132;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GRsjkUCBRCK0XqK5EykZpEqgmM36DhCdGEVvbfq3xnw=;
 b=f45BUyh6/3qPQFHJGe+uZv61gJJJZzQpdTW245pzX2XkKx4B1AMh+lj8g0LV83ks7J
 IGy0ldBUnDNRVWHT8YyDcRTUG12I6T0OwfMinQGfz/sMezPSpiAInPVirDw5/5vBMC4m
 KfMEK+RH5xElRGB0qKF7kKhN4AlRjLon2kZGBfgzeoera3csbdBbD5FwoJIbSNHZIS2R
 cV02gnBMgc+7HsfLk053QyeYHPUanOQtaZw7EFmF8xtWd4k0WNlloQkrTMk4zVOlp8Qn
 OKBMXxDNi9q60meO/Fk7dSrO8R4+VGnarns8f7rZ7FJ+a1aWxMW9l1SV+4HO5lgSt8zF
 8WDQ==
X-Gm-Message-State: AFuF++kVcdqEnNUdtJkCRSn3rXPCkH9/pt4PfzpReYxuNAnHh2AjgFMQ
 iI8gIYe4pRwDBIgf1kDFLCLj+657DTnErOnBGOODI2GY++ntLuwltJYRv/P42yNVEWNF1lo0KcA
 ZAgL6+1E=
X-Gm-Gg: AYBFou0/MWqLROwLdh8uVTe+pR50UEnVORHcD9PxwilWRsYCgq11HklL5W4k0BE2ZxW
 O0+yJetC7+7KRvXg2X/m1unvn8wOQIm1m5sysQrbY4K9rQh4C3MNmc64EDwEeaEVUjlWDWIdZWJ
 pAOnnClGI9iG2c/agdfXWuvSFZz1qlKO0tEzHkaQcatChIzjwM9UJr52dwtp9vB5IikiMzlZKNW
 ipsg47DsKnW2WS4uliUI1CO+pVR/H9BVAb83+9GmliNzp9Flq7UiLRrf4po4Ps0Wdtb1xYBzPg3
 bn796F7w0Cbib2VsjdBLQOUQ6BYq3u2EA3/3hy1Hz6iafb6hlElVHz19SmIGyv8B9DMnJ8UhMJJ
 mb7Zn4kFPz1GzEs82Z/D0yksasA4X3vo7Beqk7UUaon5ij3JqhsabhwbQ0zD+3mrVbtLJm4fNQV
 IkhkbjIEf+oSPZNZQQqSISw/foyRsBulwRPpBTzn43SdLxse+fal2Phkig0dMM904LnvrVlgIcT
 KDPd7f8LIZy3A==
X-Received: by 2002:a5d:5d05:0:b0:486:e5f7:89c5 with SMTP id
 ffacd0b85a97d-486eb1d85b8mr7649647f8f.1.1789121332147; 
 Fri, 11 Sep 2026 03:08:52 -0700 (PDT)
Received: from arrakeen-2.home ([2a01:e0a:106d:1080:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eb2ed0fbsm4978390f8f.3.2026.09.11.03.08.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 03:08:51 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: u-boot@lists.u-boot-project.org, Scott Moser <smoser@brickies.net>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Dustin Kirkland <dustin.kirkland@chainguard.dev>
In-Reply-To: <20260806181818.197191-1-smoser@brickies.net>
References: <20260806181818.197191-1-smoser@brickies.net>
Subject: Re: [PATCH v2] dm: pci: fix uninitialized fdt_pci_addr
 fall-through in pci_get_devfn
Message-Id: <178912133160.164375.2227219268136973863.b4-ty@b4>
Date: Fri, 11 Sep 2026 12:08:51 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.1
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

On Thu, 06 Aug 2026 11:18:18 -0700, Scott Moser wrote:
> pci_get_devfn() reads addr.phys_hi and returns the low bits of it as the
> requested devfn even on the -ENOENT branch, where ofnode_read_pci_addr()
> has NOT written *addr. The C standard leaves that read undefined; in
> practice the returned value depends on the compilers stack layout and on
> -ftrivial-auto-var-init. That value ends up in pplat->devfn (set by
> pci_uclass_child_post_bind()) and is later compared for equality in
> pci_bus_find_devfn() during PCI enumeration, so an under-determined
> value produces an under-determined driver-binding outcome.
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-ufs (u-boot-pci-fixes)

[1/1] dm: pci: fix uninitialized fdt_pci_addr fall-through in pci_get_devfn
      https://source.denx.de/u-boot/custodians/u-boot-ufs/-/commit/85a7290d4bc976a57c7ecbcfcc3d6aa67665ffaf

-- 
Neil

