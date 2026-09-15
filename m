Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1610EC88E7F
	for <u-boot@archiver.kernel.org>; Tue, 15 Sep 2026 15:53:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C7B0C80AA0;
	Tue, 15 Sep 2026 15:53:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8OJPie7Y1hUv; Tue, 15 Sep 2026 15:53:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 16FA1808E7
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789487620;
	b=EUODDkE9dD3CTHou/lIP884EIh4H5Ii+f+QlDqNoJW+SmYCHh40h8caBEinY4N9iD3BE
	 GibkeZWW6Z1gFGYzWyrnP/iyBdnHhtAPBiz82iGRTVvM1c4es5JrbCqpCELTfPlsqv4Re
	 LNuUr6/AwBpvH27BVxNrMbDlJTfXDb+JDeAEvibK4QdX77Ho4zWQMCrjagsHeqILKWEGq
	 6bgJi8vkHveasG4FPY/1W1ZhD5dUsbmDt4Bevrj7FS9yJLDK+2zw3d66aKPIBw6qTMiPZ
	 rKuZS7Nhu/6qZPp+kJOxOwVkgzDHsSLBsdQNa1XEzObBKuzmTNwJMdxObrD2MC53Cew==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789487620;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
	 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=5nyfqAvJexh8vIMraJhYEB60kWszdl3BRlfXaMUozsU=;
	b=fy5u8g+Ce/qUPXvGizWvz/RuytNIMjmE7Ta34GGscvDfSupA3siDHSqNbhZHNh0/MV6R
	 aa4DwLe16c87uzRPt5msSboMcFa5zP2p3Cj2I3L9Tp528Wi/A0F1qO8SM/cfywAP7BG+k
	 2DAb+mqyh8f0skrn/lYhrCkGaaOLG9Gnn01I78Y2pVfXz7uUhx/+5pO4BllDud0xq5RJg
	 jamiFW3wu8FNXtVzntR8b2oUACYXe0ol11jmN0FHWwOCOyyKXFmDIhqPS+gli4WitWnmD
	 IaYGrY1nrGAmqqTfj2l8d6tGBLLABScZ3DOCDjdI34veGJnnwVb7OjrK7WdDZdOoIBg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789487620;
	bh=5nyfqAvJexh8vIMraJhYEB60kWszdl3BRlfXaMUozsU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Ll3m0dAgNP7HxvCTunuza21YqHldCLt8anFwjRCuPeh4LZVq/LrRfqUT/xTKnthbF
	 ljRczE/PqQsHATHSvori5QT7iZSk+tupjqbJOpxTD8Q1mY46i1au5Y4cgH5fDhMBTC
	 zRpWKwCHQsiTzkG9pVgeUMI+U5ZpIFM5fuV6w/PxSfdfjWFsDTwgMKa5Tqsn3s2iKg
	 4JleH96/jJACaLzw1XsDpsVUlHHhlw8e5cnmHJXo6rmqMU3cCMt5lR+Yw6AuILH+FU
	 DohbTZuacfEO2t1NPQJG5QHlm72XNSWiSIo/0pLrHCwXP5dZvJ5UeJZ72h4SRlXTZr
	 E5E9tdstsHbGQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 16FA1808E7;
	Tue, 15 Sep 2026 15:53:40 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 230BDEB
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 15:53:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 08F2640525
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 15:53:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kB-wWKh9AHer for <u-boot@lists.u-boot-project.org>;
 Tue, 15 Sep 2026 15:53:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 6031E404EB
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::14"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789487618;
 b=X2H3X0swgX2Gm/TSRWOI0+eUqN93jxmL0BIKwU582OwSIC+zKAfXeYwgRNS10GL0B+Kv
 77YAQmE91ZATsZGFCejeqo2h3tqFKLSoiWGxzBlxblV9jjONu5dqhNT9vzPySuAj/NuVl
 k98TmO+hdrAs5yfftGpxmVAjOaMX2mWsifKUBte5F+9fUx/9Y0YyDhJdRtNzBFjMiPcyF
 MN8Xe/MD+Ca4vw7vDRIwKXn/4nDqdoNGXNNj0WtfdosddHYHIZNxRRAzrLG9x6xETkv4U
 Mynm603gYvoH+EBwVVRp6c4on/TX/NYGV+fTJzHr+PXN7uHEWIufuBsS/SqJvdCKLqw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789487618;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer;
 bh=5nyfqAvJexh8vIMraJhYEB60kWszdl3BRlfXaMUozsU=;
 b=PqY8PNiWMsuaX6oLrywS26ja90FwqGB3P8noRM6WqswaS7SImPjff5xbcKYkKXsJC7wE
 nsp7qC1ymrgpGI6YYHk/m/nF71G/MI9psJ+xqqClmmcuek/j9kWNhia60KIKV/ZiWVNWw
 jzrvQNjk0uG/YeqAGlNJDBfheSNxwCmQjGVd5OISSoegoHwMYdqqKrXu4X5X4EUT+PeBl
 PbFTG2ta0TWsGFq8HMMt7XL/BXeSMprz46u8cxERMdUdyju9IeKGzNol8CZTh/oeTBhJb
 fTdd9eAt6X0cKCnjcBb1/mc2tEOGwg8k8qFEL0v3FQf2JM4898lGmW9jBLSh9PrIo/Q==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=ekh54zWI; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::14"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:31::14; helo=mail-oo2-x14.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=ekh54zWI
Received: from mail-oo2-x14.google.com (mail-oo2-x14.google.com
 [IPv6:2607:f8b0:4864:31::14])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6031E404EB
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 15:53:37 +0000 (UTC)
Received: by mail-oo2-x14.google.com with SMTP id
 46e09a7af769-805bf8c2661so2454365a34.3
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 08:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1789487617; x=1790092417;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5nyfqAvJexh8vIMraJhYEB60kWszdl3BRlfXaMUozsU=;
 b=ekh54zWInhWO6+IJzhNIMDre2QoN4pfx7hAqee/+ky9QO0RtVjnG83g9CJg6/SG+uF
 PfZAxYUTmbQ+NgapImlE8sqoe3gmW13aGdtho/KbDAH5A0JW/rakT/bhDbz3+UafdpGp
 ysKdsQrBnPb/xK160blfYDh5LmfKdJ4ePEzxA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789487617; x=1790092417;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5nyfqAvJexh8vIMraJhYEB60kWszdl3BRlfXaMUozsU=;
 b=pYK/EzDWHGA47zdVMMceGJ9PDC0Q9dAk/9mhoamm/U7/oheMjApJ+ca9TPtU+fbsSe
 pbz+Lz5rB/kBy3QlIXGN1SJ1U6MzD6YpehMXiiXlBNSq726kYqJoejJm9zsppIs4G7qT
 gw7TIgU7AFPi8+MPdfh0An6ObaTO97tIup3t/Rp3+D+yDvOkiRNvHJW9N4kPeNN/NDGn
 +RD4NFa9Vd5UIlOzQre1GIQJBMmafq+z+uMcSCMt/KQpI6D/Ot4ZJPeBsZM3L61jSoi/
 Albn30O+WAK1r3m/WRt3Lsx8eFUD8sKJdLk6aYuPDozjHDMF70zLTez+roOfst8GzKpu
 0wGg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzYhuiWaWJq3WsK7bGjBNcpVvOF4m+XfmSJS60cRdE9On5vqHBJQsBgwWPPuIlEWt1HXxr41u0=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++kFWw4M12yTK4QkANrknXsGNjrJjG+AuhCsm+yzCA5zrA1cXbjA
 yCCwItpKChQfykqdEKEXjiz4U6ssHMtXm1P6QawOyeJoFh2V/JBDtjEZ3CrcTrsfSk7J+68MXsq
 LZcEwoAqIjB4O
X-Gm-Gg: AYBFou2Mkb1RS5Hu+5DnrELuxw3u94QNzSu5KVMZLbb5QZGHreKy2EN0gIj3Gb8CyZV
 Y36oBF4LHahsDBskzHlFvjc5hay2y8YnOG9H5WqRuHrQq7eTL8YGik04cKNf8F8qNkCjy00p5dA
 E8HS2fhu8RICxzj3BXx4tCd58gQ7nFgetb8hR4SJWd/555QNeTBuej3j127TXQBrc+EM9mrD0qC
 ePRez0JSTqcj+qhMlcmyPLQCcT3qbxjPAWYduPQEOP2xua5+7ngZOLtw9Rfmnh9n5T00Tyb02wb
 JD4DstnF9rBS/h2TXPQPADXq0oKOoIwCOK8+bgSEWCYFgybtPsSyANUl0wJDqVCNUZIqPHDlYM/
 UN6OFbwj/RyfB1wKc4r2eKYQn17gUwGf6lNebHQ7Qs3WfAduHm501TryCxoZ7EQRW4rpjA1pIpv
 hN5nn0PquiWOfchAZsrXVpi/3pa4H2hu5Jp/rXOPM1JUp1QGC6i+96Pym3HW1t6qDW6wycPwXlU
 75+EZCL38tYBavU2Djc4IKzocxA1Mzbvp9rCaPD5me8k6+/ZToNKccCbAALGUnr0MqRGucOTYCU
 Va+ubpJveSescWxK1Ze85JZ8gd7uWA==
X-Received: by 2002:a05:6830:34a2:b0:7e9:adef:4fd4 with SMTP id
 46e09a7af769-80897e80bbbmr6490349a34.11.1789487616747; 
 Tue, 15 Sep 2026 08:53:36 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-807bd0a4cbdsm6521377a34.2.2026.09.15.08.53.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 08:53:36 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: tuomas.tynkkynen@iki.fi, bmeng.cn@gmail.com, sjg@chromium.org, 
 jerome.forissier@arm.com, Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com, marscheng@google.com, 
 u-boot@lists.u-boot-project.org
In-Reply-To: <20260829193443.2666920-1-visitorckw@gmail.com>
References: <20260829193443.2666920-1-visitorckw@gmail.com>
Subject: Re: [u-boot-test-hooks][PATCH] travis-ci: Add 9P device support to
 qemu_arm64
Message-Id: <178948761572.872400.5827198532611190996.b4-ty@konsulko.com>
Date: Tue, 15 Sep 2026 09:53:35 -0600
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

On Sat, 29 Aug 2026 19:34:43 +0000, Kuan-Wei Chiu wrote:

> Expose a 9P filesystem device over virtio with mount tag 'rootfs' to
> enable testing of 9P filesystem in pytest.
> 
> 

Applied to u-boot/u-boot-test-hooks.git/main, thanks!

[1/1] travis-ci: Add 9P device support to qemu_arm64
      commit: c939ed86a1500f3a55842211e4b2a9a4fc9b8a7d
-- 
Tom


