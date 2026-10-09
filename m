Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2068CA6017
	for <u-boot@archiver.kernel.org>; Fri,  9 Oct 2026 02:39:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A12BA606C7;
	Fri,  9 Oct 2026 02:39:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Utr7JzLCodB0; Fri,  9 Oct 2026 02:39:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D48E16082C
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791513553;
	b=NbLFoya5JFuZ0POOcfQPyQ+z3QKxPj1BFwK040AoPht/Pnr89oTJ4Soa+xjYakBRaT+z
	 0WbS32PY4r4/PkZ338pD+y1ueEicQpxHwcoYvTdbbJBqpVPtk7gmMshlUfcFamNajJR55
	 LC/ZkrbC7kXfMwBqubb4XLIf45ZASTU3yMq3cvC1tIB7GBQaZrKOwmywbCHh/SpxG4BUg
	 B25ZnJPd0Kmsknz2Ok96EC6viCXFKuZQtFK37r4lpo9Vf3c96RdijUpDIZslB9ZgRH136
	 Kke9V3gnMpWaDyW4qCfG/KlapTkMAHCBMzHJ2zpUjd9LWg7YD4jIY7hnIs/aCuABRJg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791513553;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Zoho-Virus-Status:X-Zoho-AV-Stamp:X-ZohoMailClient:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=RcC8JiKFx8MOr5LUQ85npfQwDJ36KhvtqEJS4navM9o=;
	b=Nm32Awpap1cWptzyiioHpOqbN81b246dgVWxcm+PU3v3rzrUPAoEvD2fb8SmV/kN2uVG
	 zOo+RgcVjheZF/Pb2J+Lb6Jit9XeJCd1wfJ6+oNiNi2KvJORtsEDn2yI7ISBuTzrqqWD6
	 mi3IxG4HG9oI3HRcLmdOswT/ZaXf5MsPFZK1FXNefua9aEe+H/zNI7SSrbxOa+HlxL7E5
	 Royw4whEUV59mUU5HWAOAJtaLDJbZ4cdk1miqQTXrcEkbCShUy0EZA/ecVhfFaw8iwZ0o
	 gTjWUci6aCJP2t3j6lbCl1dVR44WHGZUzG/Rt4mHgoB28663CerZcYxLK6bPR5k1eyA==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791513553;
	bh=RcC8JiKFx8MOr5LUQ85npfQwDJ36KhvtqEJS4navM9o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hHfyCBQh6FvoVHA4pTea6Fic5WDstCzTkHR8v9glT9+kXErJY/3yXYqI5mgPPZOuG
	 QsAnP0yn6dhwSxDwKu/rIjocYPxSNmwr9OITSVNWzIDl9rX/DeUaW9VFADu7XGwDtk
	 cMH3f4FaPmHa8wPU07HCe2eF5NmfOPEANGQ/FLjtZ0cMi7RMiTPWFPuZ/B2Ua8RqSq
	 frjuphc0emNto1hPGBelCY9PbVGYbkF0IdnxtV7OscE+M979VP5Ep7iIsoRTm4qTE7
	 5/3lvOUQMz5yVgPI+d6XQU09GsjY2JPrQWI52VegqoSbTIQ5LzgOrgrOGABf2FBb3c
	 0MugmNs/dYovA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D48E16082C;
	Fri,  9 Oct 2026 02:39:12 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 25EFF228
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 02:39:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 17CD5813B6
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 02:39:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id T88ju3PGySOC for <u-boot@lists.u-boot-project.org>;
 Fri,  9 Oct 2026 02:39:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3AE6581323
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.182.15
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791513551;
 b=GjMcyxh5fbMaxfc1lu9pYBUu8ji9/oqYbAONAbfHLPEryL13oi4ONUv4pv7BNAQ28o/T
 xSc4dNYDSdt23cEF//niMb0CRj9GtzexTAva+DsWu8kusL0VjXe8srQFjIEK3AkGK0FUl
 FyhTidPMY54TlIsDhFWeu3TmQny8SnxsHEM8WLEb9jdNk/L/Sl+WC4WOSH+cwIQhs03NR
 opTefpxXSf5IY2Tkw+RT4kSbZQ1xTOBGCKz67sLORb1LnsjtbElIO6s5esnOhWNiioene
 84NCkObW3VvaBzPzIYHCU9HK+bMJs3L92/gaHKXTxlyAezT+rtbj5bR0z+k9UZH06MQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791513551;
 h=Received-SPF:DKIM-Signature:Received:Date:From:To:Cc:Subject:
 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
 In-Reply-To:X-Zoho-Virus-Status:X-Zoho-AV-Stamp:X-ZohoMailClient;
 bh=RcC8JiKFx8MOr5LUQ85npfQwDJ36KhvtqEJS4navM9o=;
 b=QsAZEJlfFcbfhFjnp3Ez0rf6jTaa9p7z8L0DX72U21GK5t2a3suGwbcPjyguoAqsFnoE
 +2Pkd358SoCN1m4AgSv5+i8n8WmR1rTSPYZoFKVrVTg+ul8upoEx7LJlRvFzSS1voRvHq
 qGdLdUgAVMTP/vR6NGPgfyFwUN3Zi0w8I6WN24tIgkocyfeht0dGdb6zVstINa71WNLCG
 koFd+m71+1VqGgt/HrQ9tm0875iHeVGNQWI9T9oEisANOrGzIQveKU2SYZqDbQEe+GQ5s
 ipKn3rtYBuyAVYm0f8vUTAqdBffLB0h65TBQuv+VDKZ1TZ5bjSNrlBXCsO/mluLH8iw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=ziyao.cc;
 dkim=pass header.d=ziyao.cc header.i=me@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=LWA+8MHo; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.182.15;
 helo=sender5-op-o15.zoho.com; envelope-from=me@ziyao.cc; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=ziyao.cc header.i=me@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=LWA+8MHo
Received: from sender5-op-o15.zoho.com (sender5-op-o15.zoho.com
 [165.173.182.15])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3AE6581323
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 02:39:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1791513516; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=FFsFa40ktu4wYPU6jqAfucgTstSR6A0AibCEQxKGRpzbpKdzmKi9cyEPetGlNPGYOD2myekQLPXWATPm8GVPiHrHOmiQrF0Z+t1GuddNhar0BwN6RPetFxRrz/PZUUFw/ukzFAWt0Ub/ng86cZ60tIFlCSGnrvFmO4OJvh1Jlek=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1791513516;
 h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=RcC8JiKFx8MOr5LUQ85npfQwDJ36KhvtqEJS4navM9o=; 
 b=k7BqzmewG5z5nAanX9oruPqWfVsf4n5CpiPfjEEdKOBE0hHINN6weeGK4R+kK560F29qXGCVXNvIE0dkRmxICvEp6oAGfnMsCY/dYCA5isUVOKuJh4vTEpFjjvsFoS0qQDXar8+E08NtI356tgmd/pIz0+K0gBMALS18VpIqRas=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1791513516; 
 s=zmail; d=ziyao.cc; i=me@ziyao.cc;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
 bh=RcC8JiKFx8MOr5LUQ85npfQwDJ36KhvtqEJS4navM9o=;
 b=LWA+8MHo+ChxHNnUwdYX7XR9G5+REq+THdfhTcOPT/3eIWxQ05qfmDetQq3l0Wwc
 vAMj7zq30jpeEAAsXJ9TrXMUQ4Pzk0RcFhStIKnf4gp+7UqByCFGwZwqbtVaR6JPKjl
 raxBL/siGO9n1PQ7j9f1aqlUuSkDcs++t/LFjG6U=
Received: by smtp.zohomail.com with SMTPS id 1791513514326974.3406046071227;
 Thu, 8 Oct 2026 19:38:34 -0700 (PDT)
Date: Fri, 9 Oct 2026 02:38:23 +0000
From: Yao Zi <me@ziyao.cc>
To: Zhuxu Ran <zhuxu_ran@zohomail.com>, u-boot@lists.u-boot-project.org
Cc: Yao Zi <me@ziyao.cc>, Tom Rini <trini@konsulko.com>,
 Johan Jonker <jbx6244@gmail.com>, Alexander Koch <akoch@initse.com>,
 Kongyang Liu <seashell11234455@gmail.com>,
 Hiago De Franco <hfranco@baylibre.com>,
 Thomas Bonnefille <thomas.bonnefille@bootlin.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Peter Robinson <pbrobinson@gmail.com>,
 Leo Yu-Chi Liang <leo.liang@sifive.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>, Heiko Stuebner <heiko@sntech.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Marek Vasut <marex@nabladev.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH v4 0/3] rtc: cv1800b: Use the RTC node for time and
 system reset
Message-ID: <ashTn86KV_tfQS8w@pie>
References: <20261008-cv18xx-rtc-sysreset-v4-0-62cebd76d440@zohomail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261008-cv18xx-rtc-sysreset-v4-0-62cebd76d440@zohomail.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/291.503.33
X-ZohoMailClient: External
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

On Thu, Oct 08, 2026 at 07:30:45PM +0800, Zhuxu Ran wrote:
> The CV1800B RTC subsystem contains a seconds counter and system reset
> controls in a shared register range. U-Boot currently binds the system
> reset driver from Milk-V Duo board code and accesses fixed MMIO addresses.
> The upstream devicetrees describe this subsystem with an RTC node, but
> U-Boot has no driver matching that node.
> 
> Add an RTC driver for the seconds counter, bind the existing system reset
> driver as its child, and obtain the reset register range from the shared
> devicetree node. Keep the existing reset requests unchanged, including
> the warm-reset sequence currently used for SYSRESET_COLD.
> 
> This series depends on the CV18xx upstream-devicetree conversion sent
> as v5.
> 
> Tested on Milk-V Duo, Milk-V Duo 256M and LicheeRV Nano.
> 
> Signed-off-by: Zhuxu Ran <zhuxu_ran@zohomail.com>

I'll prefer to keep constant names in PATCH 3 unchanged if possible, to
keep the diff minimal and easier for bisecting, but this version is
acceptable.

For the series,

Reviewed-by: Yao Zi <me@ziyao.cc>

Thanks,
Yao Zi
