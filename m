Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 553E2C55184
	for <u-boot@archiver.kernel.org>; Tue,  4 Aug 2026 18:56:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 04C6F60639;
	Tue,  4 Aug 2026 18:56:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DOzjgrpnMaqR; Tue,  4 Aug 2026 18:56:56 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 64A0A60750
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785869816;
	bh=SxeHygcfObS0KMN6Hk7VBNd6HmQl1qiJpWpMl89ckoQ=;
	h=Date:Subject:To:References:Cc:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=F4tIJoH56l3FWAoXw4WGzY8ka8yRaDmsJhUpafU1dkmcOMX5aztaElTeP4L/UBXRD
	 Uy82b1qTrOnOy2OIzmqxBaXyEbVVRstTEDzfsDWcdx4OrJfeyab3d9Igx6NrQ0i+/9
	 jCbO4usHOtAJr4keS8VhqyKTVrVlrPHfVbdYtrUTsJnaVTErUdJ6HV3jHYchLfdwP/
	 S4M2QKk3EuWyDM/JHt/PeBrxnANnIKekRH8raoAYmIgEmlKENmGkdLg6z4Mbn0pPCy
	 E5Mv9Vg1j3CrIRjPYJ8vcREz0xqmfACdzg6sbVQI7/2ZHDpr2orZnkW8hQ7WXO7pG1
	 HVgNpkreeE07A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 64A0A60750;
	Tue,  4 Aug 2026 18:56:56 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 44FF923F
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 18:56:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 366C960750
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 18:56:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wv-wlOiRFVbr for <u-boot@lists.u-boot-project.org>;
 Tue,  4 Aug 2026 18:56:53 +0000 (UTC)
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=srs0=1695=f6=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org A238F60639
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A238F60639
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A238F60639
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 18:56:51 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 049F684867; Tue,  4 Aug 2026 20:56:48 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 719CF803F6
 for <u-boot@lists.denx.de>; Tue,  4 Aug 2026 20:56:45 +0200 (CEST)
X-Forward-Email-ID: 6a723540f4d6979be0b7af67
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 2.13.4
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <66ca20c5-14c8-4e1c-be42-774428a96f51@kwiboo.se>
Date: Tue, 4 Aug 2026 20:53:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/9] ram: rockchip: rk3568: Simplify get_info() ops
To: Stefan Monnier <monnier@iro.umontreal.ca>
References: <20260804105721.2402406-1-jonas@kwiboo.se>
 <20260804105721.2402406-2-jonas@kwiboo.se>
 <jwvcxvxuces.fsf-monnier+gmane.comp.boot-loaders.u-boot@gnu.org>
Content-Language: en-US
Cc: u-boot@lists.denx.de
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <jwvcxvxuces.fsf-monnier+gmane.comp.boot-loaders.u-boot@gnu.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kwiboo.se; 
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: Cc:
 References: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1785869803;
 bh=SxeHygcfObS0KMN6Hk7VBNd6HmQl1qiJpWpMl89ckoQ=;
 b=u1edCmAgJ/wnXdCX/bIVnOwHqE59Uo9m4f3ONY6crksXGxGHXENfOAHRDyUQ2J0I3A5YTZfwS
 5TtZ3KuVqbPH006pF9V9YPnpkVtPvoh5bnVla4LR/wKmbBF5Yu+X4HMgLstuGNsL8r0pXuAFhgf
 n22W7iBGmLfx2yhAwWWBAkELig8SIUIzO7MGzF0B4uvz9sYs9fvdAb7aApvErZyXRAAhOfsCdRn
 fAqrJ9fnbUjaDGjRHnR0gmbz6e6O+kI+uIfXEdDI1RAh5KYVqjrjOY+DAaLq/oqbwx43y+JGepT
 t2pzmsI2JAHKc3xOKzTT+V/UjuQLlap17QkjvEZL+zoA==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org; spf=fail
 smtp.mailfrom=fe-bounces.kwiboo.se
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=u1edCmAg
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=1695=F6=kwiboo.se=jonas@fe-bounces.kwiboo.se
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="u1edCmAg"; 
 dkim-atps=neutral
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

Hi Stefan,

On 8/4/2026 5:38 PM, Stefan Monnier wrote:
>> +#define PMUGRF_BASE			0xfdc20000
> 
> Could we get some comment here (or in the file header) hinting at where
> the magic number comes from?

I do not think that is necessary, we have defined base addresses all
over Rockchip platform without any such comment.

The base addresses are clearly stated in both SoC TRM and the SoC DT.

  RK3568 TRM - Table 1-1 Address Mapping
  module	start address	size
  PMU_GRF	0xFDC20000	64KB

and

  pmugrf: syscon@fdc20000 {
  	compatible = "rockchip,rk3568-pmugrf", "syscon", "simple-mfd";
	reg = <0x0 0xfdc20000 0x0 0x10000>;
  };

Regards,
Jonas

> 
> 
> === Stefan
> 

