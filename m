Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29351C5CFC1
	for <u-boot@archiver.kernel.org>; Fri, 14 Aug 2026 21:13:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2EC3E60A90;
	Fri, 14 Aug 2026 21:13:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eJjVWVVbBrFy; Fri, 14 Aug 2026 21:13:18 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 718C160A77
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786741998;
	bh=k86GQpVYJdcdbFGkwNH886vQcrodJpVW/Nvx69g4400=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RtqGj54nqkVaGFbz2/3MdhFXFAJPyeJA5YW9lS5RGlNWCs6zFwGGmUKEwilFT8mel
	 5JNrO2/1d967qCtcPpaTmcC9IwoNR23m4+/xfcOy3MfM/iE9ssZpLCAAUwACqwtqxl
	 aBdiUUCOlLM0iDqK7v9jBhfr5/KUW5TEotMUJrdymfxGEG0ub88qRpPquy0vkTWrla
	 1Kv5fUuhxPra+IY0dWHb3fJgSH9ENBlrirL0jDPH8tU5EQBsgiSklY3cSp3QsYcuLv
	 EvuJ/ijcbAwqi4LQIzl84ANY8jZUXKGk0AvugxhyDTldD/lwOaDgZ7B2+VB3n8SHCk
	 s2t7TCx/9soEA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 718C160A77;
	Fri, 14 Aug 2026 21:13:18 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id D81883DF
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 21:13:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D60CE409D0
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 21:13:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4KqkKPKCgvpU for <u-boot@lists.u-boot-project.org>;
 Fri, 14 Aug 2026 21:13:15 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32e; helo=mail-ot1-x32e.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 2F7A5409C5
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2F7A5409C5
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=bukhoe/n
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2F7A5409C5
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 21:13:15 +0000 (UTC)
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7f3a9779782so960197a34.1
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 14:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1786741994; x=1787346794;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=k86GQpVYJdcdbFGkwNH886vQcrodJpVW/Nvx69g4400=;
 b=bukhoe/ny5fWWPt8sCbZ/a2gMKmcYy8F2fnwsFQU22lv8uxw2nl34DJM7nVxUJmvKy
 XqpuLDvzpevX9BXmzkvxsB0PiYwnOOo6FrjBPjgodmg7duGh01iNMkYIh25xovqsS7fm
 LENQcVLcZoPPzU5WJrO1eayocgCbQZ3DVO5oo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786741994; x=1787346794;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=k86GQpVYJdcdbFGkwNH886vQcrodJpVW/Nvx69g4400=;
 b=EAD1Fhq/fRp41UCCB59mIilte7rMbrESreSrsMO7OkYR+nF6N+0GxH8/5gcNV7wJUE
 zR2p9vd+8iUfAUpaCL9WmMUVhg6fbanXvufxPd7FJUmd4KbG4h8DJnU1XSv+CmtIzFp+
 Mtp6bDHCStpEPK+vNsbQlB1HWgvdHbDdpmb5IKi4BziDr9XMzjTyNNy3oxz83gD4hZnV
 B5L/vNdCL8ovgskhwQKDO8QKo+nMGjY6pFJAriTxpBPd3xfY9cLJDAJApEY6QMvcNeek
 pLIIysjUUWhQ0MoHlSrxIUKYrEfDoHGrnKXeJjJHepdZJQ0dSs9FAoDvfdkhiIbAC3lr
 osNA==
X-Gm-Message-State: AOJu0YwPgWB6iJ4m3W8Kj71cIcaBY7G5U++GiYlJ09m2mZXi2vob/gtQ
 wL9IZKgHSyQmQREG7Uf0087ZNIrKLjj20EUj4cFPIP6BoamTXFwyxf4YQjJMbR8B5EywbsGiRQ8
 8koFozNY=
X-Gm-Gg: AR+sD13UtEqau0kfpulmv2SfpnBWEXHnhuDf1cdxkfe77g3/SHOW6jE9QRm1LfraNz2
 X8D+gbuSa/Twf+t6CWNE0iUOKvGB53a8grxJxaNdmHr7YinQ24SibG9mL6IpmgltNVHQjgpXnp3
 Dxqq4KdXR5wK4gEa4qZt17ymabf/ZjXm7aBXJjv22vL9s4BxQ4DXg/bxMOsyArcqRtqZ1s4HuTX
 y/TzXKFrcdvF3HWnfvii0EYbHZCx5Uipb9ZTMbIx8k6gN4TDGz9oaUKzUs1IM/ZSkGYGkIw4PpE
 NtBaGZXBKU4xidRJZoJLXsgnlDsVBpE5BE5Z5UyRYF0UpbFMP5O6M6StDlsm6yxkuSgZj4opcwn
 yEyIyjBXbEMeO1LPGmeVbXFa8bZ7ac77h14OsMr9sbL28LXP8UhEa50n9uqnz9r0sXXXbO986IY
 7s2h4yCEiqX7Y1MtLrXjeJ3bPA7yWRzX8h+6N6BHbCEnrv6pm9ssJt7qJOlcSpQmyb80Ean+CeA
 taUBnTu/L2HghcRSs5Fpy0tgZLmSjJiwJMiMm8KDL8VBmhLsVv09Iybek++heXmc+vLDBqppnoK
 MMs5ZIb4
X-Received: by 2002:a05:6830:a8f:b0:7f3:a8ac:45fe with SMTP id
 46e09a7af769-7f3de647942mr7284295a34.11.1786741994159; 
 Fri, 14 Aug 2026 14:13:14 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f3e849474bsm1785868a34.2.2026.08.14.14.13.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2026 14:13:13 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: nm@ti.com, robertcnelson@gmail.com, sparsh-kumar@ti.com, afd@ti.com, 
 rs@ti.com
Cc: u-boot@lists.u-boot-project.org
In-Reply-To: <20260730231339.1020610-2-rs@ti.com>
References: <20260730231339.1020610-2-rs@ti.com>
Subject: Re: [PATCH] board: beagle: beagleplay: rm-cfg: resync with am62x
Message-Id: <178674199341.3904324.4131862429138909927.b4-ty@konsulko.com>
Date: Fri, 14 Aug 2026 15:13:13 -0600
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Thu, 30 Jul 2026 18:13:40 -0500, rs@ti.com wrote:

> Apparently this wasn't being kept in sync properly. Commit 2a64978fa89a
> ("board: beagle: beagleplay: rm-cfg: Update rm-cfg to reflect new
> resource reservation"), which was supposed to be equivalent to
> 7f9c2a6f7be7 ("board: ti: rm-cfg: Update rm-cfg to reflect new resource
> reservation") was subtly different to work around this.
> 
> This file was missing the following commits:
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] board: beagle: beagleplay: rm-cfg: resync with am62x
      commit: 8841b7b292c74864acf4ed0bd8ce05839252c1f2
-- 
Tom


