Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02F03CA601E
	for <u-boot@archiver.kernel.org>; Fri,  9 Oct 2026 16:59:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A35A2608BA;
	Fri,  9 Oct 2026 16:59:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dKW2I3C0roLa; Fri,  9 Oct 2026 16:59:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E821D60663
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791565168;
	b=hlfXfjQiQuOt5ZyG74fVYzKxJOqIaNdl0DbP5n5DzoWqZWFEeIeGSVV/DsyMKcNge6jB
	 e9NFEP+kfLbxKmudEqvLwi6dT93+k04j+aUWWeFLVTtbXU9plg990mBT+La5+Xdw/ZQRw
	 LL4W2NH3+vUn8CrIj7BM3HXLc1Ym/qO/wCVQZB4SNJ+2xDdwrLKIoxZ5CtpHcJXNANUE2
	 UAVYJiipEaOVuOD9DAXa0HfVcQ/nfrCKhsHF320KmyTosiRfhI0FP62pMLeFFleNRuxkN
	 5o7YPK0gvbVMl1PPvAWPUE8Z5e2UPUTPfe36lNx+ebgBIxTz/FpTmjtHR5pd+oE6YSg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791565168;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Ij+eEINKefp9Y+xNHBEENYas8on8lS6PAeiK8fSAw8Y=;
	b=bl9DIfT9Yg2wh5hxqAw1nNDa+Lzr+hxI55hHhElojDxSXmaURhsEbcMWykS8tVEui4Oo
	 CVscJjeV+iBBNbaljixuV1Z02bUWShPGTFwxpOIjoFuMzvEweDX5CphHhjgphwK2rIOaK
	 ARhcI0IbmgAUgUWI+klVEziA8nw0HSOGn3Oc4uUhOKfWvLWkm9yFqDsPKDA25TjJ2bGR5
	 Kul0KCgWToRJoY1A4skoVDEFJa5/pyqANF223ZBmK/rjTjVy02xiD7gWprP2DnQ+LTBRB
	 VuNeIdE+UVDz/7x76DjsLTNYfJJKqLTGhJRqaR6j1lWDDsCSXNAQf7VXCBbDrjfHMxg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=none header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=O+KSnZUk;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791565168;
	bh=Ij+eEINKefp9Y+xNHBEENYas8on8lS6PAeiK8fSAw8Y=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pzZioCF6xhEGa70IEAGuUPSneEcbC9Q/EdV04snEq1fMMecpKEbLf34L2Hg/RTWrj
	 6krU4gR2kdsnuMr1HqWQ3FOEp5RvVF2eNn0TtfsGx2MoVRZg0TSiAKGbpt7Z0c16H1
	 1t7hqPhCH37L0s5qm4NM6cW4B1KLf8frlYOIAAUvL7ECgZ+RMNlYZy9y3G3ezhLA1L
	 u1P39C7Q+W0mT8WodELxOd2Wowv3fY5B5fvNu6ErZc/TIKsEtKZxqjzieqjcdU9t43
	 kJcJjkhrP+DlsUkorAhbnDT1agToWPoaCgC9u1fMKP7npTRn5Mhc/v38rUcMMASfuE
	 YvpNmmT2XIM2Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E821D60663;
	Fri,  9 Oct 2026 16:59:27 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id ED84F94E
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 16:59:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D320E60663
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 16:59:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8lmtVyPZCKMi for <u-boot@lists.u-boot-project.org>;
 Fri,  9 Oct 2026 16:59:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 9C57E6061D
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c33"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791565165;
 b=QPYH0OHqxAn4O71lNcuPD0FFCR0Y9Sj+POK4tIJImFxZ7l6zNTO+0Wi+eLOFgNdxHk52
 sj6AlkfepokoU6BvFO147vLQoD0hKDyrlD8BQcWwLhOuemU/Z736+jus0/tchkC9E7AmF
 EmhA7VS1X9H1HFZBTp3tFJDDvPe8yu6t5U84ZypTuMmjYpHnPKh4fKMp3UNPMcCBRIw8Q
 0U5yAQqcd85p7o6ngxjRmBedyz0TQqhioeEPuKbYA4i9/MHFntp1+vY380JBbY5wLyixx
 E1iYM+sBL99A49/tknadyRv3bBsU3vlAz6rNNBhztBleQBM20c66zQLgZgngNWMQjCg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791565165;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=Ij+eEINKefp9Y+xNHBEENYas8on8lS6PAeiK8fSAw8Y=;
 b=rAEjDtRj1YksOB25s8Osw8IVQetABjxlwA1f8WMOb/7Mj6d3C6O6CJlNZNfO/91kf5ji
 rDoEGlxTFKEcAr+fCm7XuVLiqhhogCRUgV7Zm1sRoM003ybI+oHbvU9EHbWIvWxkOsw8z
 Yd52WtamhkTPmu/kCJaWhu2bgfnQZluT1RLTNXASLLVekcnlC4+3Gopb23W3MQy9ecwg4
 m2nYL+88LyMp3GTLcAuaJkthsjsiQy64l8QGCswNmUPKbbuMJHXbZ1fPr9p4XhHeoWCjl
 naGoFYg5JktL+0Z8tqT0Qvs1jCbv/9wuVwJtefEwyuv79uHKxvdgRI3DvIeO930Kh1g==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=O+KSnZUk; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c33"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c33; helo=mail-oo1-xc33.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=O+KSnZUk
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com
 [IPv6:2607:f8b0:4864:20::c33])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9C57E6061D
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 16:59:23 +0000 (UTC)
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-6deb848ddd7so59085eaf.0
 for <u-boot@lists.u-boot-project.org>; Fri, 09 Oct 2026 09:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1791565163; x=1792169963;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Ij+eEINKefp9Y+xNHBEENYas8on8lS6PAeiK8fSAw8Y=;
 b=O+KSnZUkr7RItZ7+ToLuZNOwSHGtIVA/++MXf1MyGrgk9tmTcemnt81cSJU90XUaX8
 fVCPSuB6/0nBg+wcDbUGq4UllKrF3qYy4akbBxPLDGZOsGNccXTtOE/3rZiF6YnD6/aJ
 sHt7SM5Jh4evCbvyF4vBlgMqVKTxif7R5jhq1Mfo05XPqOA5QgNjku3PC361WQA6SA8e
 JKlzbP80eNgtBNh4HShKsoKrkphwEEKMK7IcapliFqji+24lQSLnSYm75qncMljbVntL
 J9TGf4jhU63C2e1ZntVlylhgZNZW7FU2bngtK60iMIhhgZErOK3cO9YCA+7nr+9KCjBf
 ENTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791565163; x=1792169963;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Ij+eEINKefp9Y+xNHBEENYas8on8lS6PAeiK8fSAw8Y=;
 b=G3Lj8QnVCvuky1fIAGxLXzrfMPil3hCCAazS2tnBbjfBKIBox5uNbys1xYYkOogj5V
 XaMsqMnQ04pk0GZ9SqdsyRXkGMTFvyNNWM+Zb8/ylr2FaR10XbYmey8g8DLRI2EIYWyP
 ygLxdB6szdvDWdiR3p1+o21suO4Z1xUGaX3Au/0hkZ3hxZBXGbdQEAIxK27lnnd2ehws
 dWMJ6Gj7sK+jI+AKjp/JhL0zsveKg60WbPeOorstGxNUyfE79rQRqNqMLDo+g8e06lH4
 aVpdFxRA57Xg1FAYFMYan0snsZ2Zpssrfyhw2qVmOpRnZbDqM6YBFf2W9i1bDiu5/W/2
 F8zw==
X-Gm-Message-State: AFuF++kn+PUHao+GpZu/jYZ13vQMo0o1tD7A4KZUIh/9A35EhWJ0m8Ue
 J9BL9pVLddIokzJOfWKIFu5WHlvxdQU00QPmcbrKB+lNnfybrDGD0yDpp8NqSaIX+Oi7DhGjDeW
 TqqHD
X-Gm-Gg: AYBFou1xbnLdy3sTykYovrTCxiNfkKdcq0DUTx0q3Gl51D7pxJOzHtSz2tIauXIaMPJ
 9ZUMNySrC4Gk6ZjRQhDUAmnU26BrYVEBktT/ncjsq2v10zl+KOWAnndGJUlzwEm1IG/kbF3ap+7
 pNmONptA8YY5N9NBcnGYb1M9EvDnk0ZKH+uz6HdyD7WD33xhcaNfkBScmBzsVLkPtAzFKYg6XkK
 laoiW5NwQcP3x4TPDDHX8KDJItf/dwLeRU7hJSD2T+jSR0VjtlUy987CblJXA8XrdqDZJ/QeZds
 5WjmBrdTXRfY2hoElhQSL3s7U0dMiIbsCb0wuX2Y0c0zDluHep7gno6JxG/rgycoCd3HGO4sKWH
 0EjIre/ndiTCc0pl1/ff8xYVl8FjkXRdZrKYshfYjiAobZAMq6VNJYaM6FUD8M+d7u4XPkKv2A2
 83xHLkRCgS02/NxpkGcV+WUMUXe6qHPU0+jevQG/8SyrV9swniapY3dqzXGJ/NSjdCKEvRHqiUZ
 cE=
X-Received: by 2002:a4a:ec4a:0:b0:6b8:ef7d:e181 with SMTP id
 006d021491bc7-6ef1106875dmr1902600eaf.54.1791565162807; 
 Fri, 09 Oct 2026 09:59:22 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:29bd:56f6:5ae7:35d2])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4a2a822ef24sm2139717fac.2.2026.10.09.09.59.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2026 09:59:22 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, Fabien Parent <fparent@baylibre.com>, 
 mingming lee <mingming.lee@mediatek.com>, 
 Lukasz Majewski <lukma@nabladev.com>, David Lechner <dlechner@baylibre.com>
Cc: u-boot@lists.u-boot-project.org
In-Reply-To: <20260923-clk-mediatek-gate-order-v1-0-085391165c36@baylibre.com>
References: <20260923-clk-mediatek-gate-order-v1-0-085391165c36@baylibre.com>
Subject: Re: [PATCH 0/2] clk: mediatek: fix some clock definitions
Message-Id: <179156512351.1248553.2500962140193415726.b4-ty@b4>
Date: Fri, 09 Oct 2026 11:58:43 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=832; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=wYUK3JvxJwdyuQMEqOqRIJyDXt9Lk5d5BXF+5t//5c0=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqyR1h96w2+sI1P2aQ8YNswM/G+/xQZPYDLYtEy
 oFRnnTx1liJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaskdYRYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AQswIAI+fve5mZ9f4lDBnROMUhlV9pk2BTXktOo2FyPm
 RiF6wZIs3ufnO0pmLzATJwpHfwscZsiwXBsyKIAq26aWYz2+OcheCuF3PAuy02oAZH/8ZW/QxDq
 J9mJhQw4B4mbmLvBRsP2WqHH5tnbdpG82g5h+QEuP2oFgyUBZWTBhNTuDCAIcaCQCuTvqjKRl5S
 2BPPW5u6iMqA/02cD0RB2HKnRJGrXlbT5w76Je14rWliAi638i3WkkZxxiS9dSkQ5Q3Za4CRx5h
 hSYgC0onLiMYhZO6vnsOgeKvX95j/Y9jGknXMYcZDYsdb/E4PwPlLHTNkJAq7X97cFYQJmsdU51
 mJ5k=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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

On Wed, 23 Sep 2026 15:22:12 -0500, David Lechner wrote:
> clk: mediatek: fix some clock definitions
> 
> While reviewing some adjacent code, we noticed that we had a few
> incorrect definitions in a couple of the mediatek clock trees. These
> trees consist of strictly ordered arrays where the index must match the
> ID exactly for lookup to work. So if anything in U-Boot tried to use
> one of these clocks, it would end up with the wrong clock or crash.
> 
> [...]

Applied to mediatek-for-main, thanks!

Fixed the nit while applying.

[1/2] clk: mediatek: mt8183: fix infracfg gate lookup
      commit: 3f0e39674ca8aed945b74f7f11d94f6ab6a45fb0
[2/2] clk: mediatek: mt8518: fix top gate lookup
      commit: 8dc45d522ad727bec150f62a9966fa03ee3291c0

Best regards,
-- 
David Lechner <dlechner@baylibre.com>

