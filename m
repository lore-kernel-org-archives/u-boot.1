Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C532CC6B1A
	for <u-boot@archiver.kernel.org>; Tue, 13 Oct 2026 20:17:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C9847607EF;
	Tue, 13 Oct 2026 20:17:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IvJit5eXJTla; Tue, 13 Oct 2026 20:17:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 147B5606B3
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791922675;
	b=WT1ng7sK0asRy3ldNQ0Owx76fcxkSy+OW5wA3K9lc5pK/WSLBa3wPGpGl5GH1kFq42oM
	 OAg6On3IMH/1+0sSnXZeNjodqL9w6P6hLCDiPW/q1vvLiLNceNI1l4mrI4gBqHNFbF6+7
	 6yIDfAVLUgBxqzRTtVQVhO/lNLFI1FCklYjFkUcmBeA7HGJy8lbYTGpDmsNeXbSvdhfD2
	 Ite2hL1jqGbSUoGZgFkjeqZj81ztWhH05XH7Sj2Jn1TdUKJ70ityeOQZP+ORZfklNCVQY
	 lB4a/kx2r/o/kllKXoqu7EghzdxaL8uIlrl9B5kFN1WkVIDZY5jMCz9iJ8jzqqsav/Q==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791922675;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Zoho-Virus-Status:X-Zoho-AV-Stamp:X-ZohoMailClient:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=hABIouI2HB9l9pw5FrJh/HiomFirv1zojMArmIDKg8w=;
	b=QXVS79PYOaMRg8EkgXHqHYKNuevBgHbvaBy2j5kevQNr5hH/s2ZRHeAi1SF71dVusUVI
	 HSun4os/d0bQUo1YA9yw7m4mtF9IiCWcZUkLhPTKbXKebP/Q6QVgcMQ+41hFywnEd8YFb
	 ApqECWezbXKTdwJOeX9zeJsqBdy36B66UGLc3PmuIcUX+5/Zvfrem3N5WM8pdx4Sw70kS
	 RY9h5OSwHK6o2afluBHGbTa0a9lqZpHM6JX7yO2eWV6Y7+3LG83sH02xgJWc33WkD6gH9
	 0x7LPcThUjGEVjc8I1Aw3+NTUMQA2KxsOI8Kw3YOxDYePeC57pfTMcgsorevSmnaf7g==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791922675;
	bh=hABIouI2HB9l9pw5FrJh/HiomFirv1zojMArmIDKg8w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fJHKz1ewEHgGiGqEUUJP6CBawzdYxXzwmPxvgwJf0Kr/e7TViqEWqLMfqg0+860ft
	 u5/2nzI5c/tKmrViUGgpUHg3xqlQP5jKezG64+ncOjJ3Rl4E6dlKmSDaSPuLugqgWk
	 bkkwHkUd3tOxiUwDSKqf0UhNSjswor4JYKwf3mwwRqVeJ24c7VVi6k6MAH8Ue0ST6v
	 m8Rk9c+wYLplGKSGxolLWGHKGn0/9NMNiENTGUiMERZFI+Ky9G85D6XX+2xH4P/Moq
	 JsS0rEllX7nEAi9bgyNCRNhKeJzUH0TGgltuy3UkafmvDVx/SC7D8d4eRWdS6qfpuM
	 BykDU2xkXBgnQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 147B5606B3;
	Tue, 13 Oct 2026 20:17:55 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 26E812AC
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 20:17:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 18A62404F8
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 20:17:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OnpnXAbo1Dyt for <u-boot@lists.u-boot-project.org>;
 Tue, 13 Oct 2026 20:17:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C958D404F7
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.180.15
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791922673;
 b=VOk5i5WteE3yMcf1GtSFQAM7aEU+LvGp+yipi5gStSqY/j5TpUntF5exOvOzqis7A79C
 BbjdESnhnRvCUfhd8k5XKir3TVErho6E3Lg3xb0eLyH0d7V1r/qWX/j7jszUMEL6YLXu6
 bP6eVW1P813HijPFtOI1z6cpi08NXkmbp7MZnQlCYyYx3EU8sFRUqzjwLRDBTkM7r3AMb
 touWhChMcQL611i/tWEZ90WjQSu485yPrnmdbkDRuFSyU+UC/CR3VMJob1iRSPIm727fM
 3Z/nLOOpi/mb6+aXliiE65W8OKrHbvRA2ScTv5BVibDb6bp0Q08lHJgVk1FSKyqUNTw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791922673;
 h=Received-SPF:DKIM-Signature:Received:Date:From:To:Cc:Subject:
 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
 In-Reply-To:X-Zoho-Virus-Status:X-Zoho-AV-Stamp:X-ZohoMailClient;
 bh=hABIouI2HB9l9pw5FrJh/HiomFirv1zojMArmIDKg8w=;
 b=OkL1AILp6EL5fb7+HkIatoty7yq0dxATsuQw/4qdKnvazSokRSIsxMXLHN49lCFmcYg2
 59rPqfQ5YuceuSVK32bDrr6ZerTSB7zJaUGL/eOXEGeyVQqugtW0N01Vo4k+llwVL4N45
 gkeeCYztcNcgLN0F/dkRpJVA3bF0DENiexgNtcUnMNsfAhPpSyDYXqryQUT+wLqn+hS3c
 1DF1SOtDsxesWlJF7j1ieashBDHNDyK/mUx0zGqCa7pGqjkvMHfZgC/65tTC66os1YxdG
 6Burng1XV1wDCY4/xAVBRrVVV76Og16UHPE13lXmFxq5YMBk+gZhZu43CBMg16feAYg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=ziyao.cc;
 dkim=pass header.d=ziyao.cc header.i=me@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=fxrS0mjF; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.180.15;
 helo=sender6-op-o15.zoho.com; envelope-from=me@ziyao.cc; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=ziyao.cc header.i=me@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=fxrS0mjF
Received: from sender6-op-o15.zoho.com (sender6-op-o15.zoho.com
 [165.173.180.15])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C958D404F7
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 20:17:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1791922663; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=OechqH6l72VzlXKgrMN6aOFFRCVA3rVMDROOphg7548aQfuoWjDF+dDD0TuaCtV+tjCQrYI9P7qaIabUaExH37ajhLqdsvrTVFjIrnLG7nGBPl0yWK9X0Ik1T3BoJDZ0pvSkJbigNh1bNRpbTgoPiL7snF4hicziBHQrhMhdsHY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1791922663;
 h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=hABIouI2HB9l9pw5FrJh/HiomFirv1zojMArmIDKg8w=; 
 b=UcsGdXqWd2CYWs85a5sSoimAg+63zzb4z7JujxNaTLtSh5JiJnsgJ6913roHzPoX3Al4fJnf3suWzYQyapdkm5T4hdORS+pAR/2r0wccfgBHUCQzzR3THf2g1M1ltUSQYhEcLiM2mr1OKgcte8kM3XHZDLj1xRIs+ljwOMxUOxY=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1791922663; 
 s=zmail; d=ziyao.cc; i=me@ziyao.cc;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
 bh=hABIouI2HB9l9pw5FrJh/HiomFirv1zojMArmIDKg8w=;
 b=fxrS0mjFG62OuQlaRRquahjiRrp822NY3UKoTwuipcJqrbvrXbdlLE1f+aaXydsv
 E9t1UBcrH6tf6U4xQ3RnqMsq8ZbwS5mjzHvMIDFLghf/yHUdJWCk1VUiA0OZ8Su26WK
 JJ0J4JxW0q6Cz0Vo0yZS5GscPv+5l30R5RWdaTnA=
Received: by smtp.zohomail.com with SMTPS id 1791922659847223.9767021793557;
 Tue, 13 Oct 2026 13:17:39 -0700 (PDT)
Date: Tue, 13 Oct 2026 20:17:29 +0000
From: Yao Zi <me@ziyao.cc>
To: Sebastian Alba Vives <sebasjosue84@gmail.com>,
 u-boot@lists.u-boot-project.org
Cc: trini@konsulko.com, sjg@chromium.org, michal.simek@amd.com,
 Yao Zi <me@ziyao.cc>
Subject: Re: [PATCH v2 2/2] spl: opensbi: Check the return of the entry/load
 lookup
Message-ID: <as6R2YFyXUlGPq4j@pie>
References: <20261012214604.1477684-1-sebasjosue84@gmail.com>
 <20261012214604.1477684-3-sebasjosue84@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261012214604.1477684-3-sebasjosue84@gmail.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/291.904.73
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

On Mon, Oct 12, 2026 at 03:46:04PM -0600, Sebastian Alba Vives wrote:
> spl_invoke_opensbi() takes the next-stage entry point from a
> /fit-images node with fit_image_get_entry(), falling back to
> fit_image_get_load(). fit_image_get_address() returns -1 without
> assigning the caller's ulong, both when the property is absent and
> when the address does not fit in a target ulong, so os_entry stays
> uninitialised when a node has neither property.
> 
> ret was not tested after the fallback, so that uninitialised stack
> value became opensbi_info.next_addr, the address OpenSBI jumps to when
> it hands control to S-mode.
> 
> spl_opensbi_find_os_node() selects the first /fit-images subnode whose
> os property matches the requested type and does not require an entry
> or load property, so such a node is reachable.
> 
> Fail the boot instead, matching how the rest of the function handles a
> device tree it cannot use.
> 
> Fixes: caa7fc2c5775 ("spl: Use standard FIT entries")
> Signed-off-by: Sebastian Alba Vives <sebasjosue84@gmail.com>

Reviewed-by: Yao Zi <me@ziyao.cc>

> ---
>  common/spl/spl_opensbi.c | 5 +++++
>  1 file changed, 5 insertions(+)

Thanks,
Yao Zi
