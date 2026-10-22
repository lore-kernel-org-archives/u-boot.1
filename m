Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1731C606A31A
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 12:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=UVS2xPNi;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=QKXRs9fX
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5B63581329;
	Thu, 22 Oct 2026 12:07:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UyTzqVbUk6Hz; Thu, 22 Oct 2026 12:07:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8B2DF812B3
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792670831;
	b=YrUPY+KMDHYVmUjbZavDkN+Ug2689lerUkGtT06+8e2PMyl4xlLrwzQzMhyBagQ9zDUD
	 83DYVrsvBVDsqNO6/yOXUbdf+ByrfMaVvRV0YfNHtwFC3OpKl1Vemq420l/i2YKE1yTZ5
	 3/UOcb8tt1hX56dB+0uJiJH6ETsavDqpsMOvroN8E7w9dIVwv7Y8Ctu+nywgkG/3mp278
	 Pex+KY3+KI8K/SAFHTc9/KBLW4Va67Fc7ifBpiEuNkiQhBkpPHylEl6iN8GKwDLIjSaJh
	 d7lsnXbz2/TM0NiEzw3kvb+EC3pP3+BiG6VpUF9HJtJDA0JOqnXf68GsK0/z6qUvTtA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792670831;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Oz3xuhgA1spM6XLNXVR9+/+uOgbemlzCtEGED7jkfiM=;
	b=HFvDFJ0znRAfU5wgM2Gx2q4LqwETzMUt58QHb14i1JsUXXIVWCLZF5nxH+PjlQfJfPWl
	 QEKi+N1gnL6n16/JAfasgINOe9xqRQStvsvRVXA4HYkpBVrepErYRB/DAFuCKQra1513e
	 U+18628aAAKRBs1872TGR55Cl64DB5bedxIrAAnakGYSZjNP+Qm1qBkLSLmYVAdi1/cNO
	 p7fTRdDuiTdGULav6xPTeK5VP4UrRfKSNwHPsFtdQFNJvt6FSv4eZmwBA8ohIi2DgbNMw
	 0NYwm0v/ynss0837EfbKHcd9zZO3MJL3WRksX/uRshRzwMY5Uivol/sS70MiTVmQvZA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792670831;
	bh=Oz3xuhgA1spM6XLNXVR9+/+uOgbemlzCtEGED7jkfiM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UVS2xPNi2Yd8BqmOvwYDRuXJZ3snnagJ2Uhyz7SdoB60AMa9VyFVWs2v2F5moFPH5
	 1jcyjbXKWpNcrjCthnk2lyVv6j4tjTrha/97wsqAFDi7nu8wHjWxJUGKpvKXp0kEge
	 wEt5/WnTGhvI1FyUSKzUyWPQFFdo+ZFSEzWrqOMhzIGjfAlHazKkkCi5kQDZ6YR3b9
	 WSZM1soiYrtQVqrGQygGyXsftmIloh36g/o258Eeq5NxXHIMSaStqrG9WBqDxYrs7r
	 hF44ha/5F3u5TAHFRRMnWH38vi1Rhbh6manKUwc3zzf7ffOYIwDFMvGSbJgioLupSG
	 Kci9EpCJBguIw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8B2DF812B3;
	Thu, 22 Oct 2026 12:07:11 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 459762A8
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 12:07:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2B96D409AF
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 12:07:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UEHV4tjbQJJG for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 12:07:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 5BD8A4099D
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792670829;
 b=nBxbebhaggoLuWeu44rKjRoalaTUReaP/Pa3l5df+RcaKVaEK190mC7K0NApEWQ262Hf
 rI7vv7/ShvlQSugxD5F6amBRUNVhlCdlm6sx/1iFY24Czwm5dbhNwhNmm6MYQrADfw/4m
 cV9gyrlIsT5UxGlwqxkrI8uGDhogmOpw4sp80MeUSN/LgcUXQQtUZNpy2C7Mn8Rq670q/
 PQ0DoS++7SZUm7fwpjTtOr2qkdXFh0UZB4R8VnqrMGWW1jiiN9fJ5D8mLIwrNo3uE/L+q
 zeBI2/KUmHhST7XsLY22U4Kx3in96ON2Oq92tARU0sCZmOgwBpNb0GQCSPEC6jAFjjw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792670829;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=Oz3xuhgA1spM6XLNXVR9+/+uOgbemlzCtEGED7jkfiM=;
 b=nAePK1O4TNcuF4aM43hgAJgZZEYGjZzEy/UX/bArJ5hEao/xp0y2H/4IwLAKMt3bdSWB
 P6eg6+R8KXyOOrcAV7f7fE8ugPDZnwWRhuIcg/vb7qWKUnGjP9ugDXdfl1X/Dh1mS6tqv
 HlvTZAzlS6NiB6D9LgwTUK3qR07OjND4eMDwgdHtvRGPwSC8elAbIyJC+h2AVF/Qf/N7C
 cRPwNVREj8RWHpg1vJx76P1BXFRem3uOCdS+wcEz/80ihufNo5uaterkDJN240CKF6ZZa
 HQ0LpiGJHTJJTRei4/Vf22Nil+5/Rc3XaWkifqPkF2KyklDv+AqPQUkdrk8AC7ORcHA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=QKXRs9fX; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32b; helo=mail-wm1-x32b.google.com;
 envelope-from=mehmet.fide@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=QKXRs9fX
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5BD8A4099D
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 12:07:08 +0000 (UTC)
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4a1e3098ee2so20958095e9.3
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 05:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792670827; x=1793275627;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Oz3xuhgA1spM6XLNXVR9+/+uOgbemlzCtEGED7jkfiM=;
 b=QKXRs9fXQ+ztalQtzK7upKeM06RpLG9IDANxevBohQ0b0bZzF3kJea1z0j8N3zJGYX
 Oimwq1Sm5zcH+BQBGQFidouZZXn2ok86d//JsETFJWWIr/1xsWaqK6pWmXQBT0aicUlR
 1U1nYXPIBwd43jhfaXUnD5AuM0O4HEDg93FIjVZ96FLbDAyhxRpjTnE/6r00B3DGRB0R
 TdtVynAiE4kAzPcO4LL1fMPvjNrhnCGU72n1XcDsjLQGeRDUg1gId/rfb9BEYHqrrCer
 f9CpycyFH4vs03g4elbVK0Nun0XZxZUYcEHTuZ8aHcQXqg/NnMyfSHxP3QcRpqw/6RPA
 RaeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792670827; x=1793275627;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Oz3xuhgA1spM6XLNXVR9+/+uOgbemlzCtEGED7jkfiM=;
 b=eJKhUo22eQy2Vg7B3bzz1ZFPIWYGiCTyzTLcFBJsZbDDM9pop7j3oOfxUr2WMwN9gj
 LeIZP56zgkxonUfWtD2t1tC8J47s3fFxv7DzlK9QR1zdx9LodbpOtRJR74Io3UvSqiJc
 y0wjSRLmOgt4UPT8f1lbzT8lgI86mug4ID6iKj1rSGZRT1y3/5UWA0OjTXQ2FbKfq/4p
 9PwyCAgCCYTCmgLijUxs6Ht+BLbHgs2oBB/115p8bjhnveEnAZOTwou18PFr9oCrLZuS
 bc4LnP9fwlv6WDrz1wz0snfLTeACHSgMax8MCNvqS1pdbqSSKJyKWBQWio9QGCUAMftp
 K/0w==
X-Forwarded-Encrypted: i=1;
 AKwUvBzMTtdGQhwv+15R+7EvE6znBqRNqu1K1loE8MW+FqIBHtaoczKpEy7YTmgFyMWA1crTFDHG+SI=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIGGB/nQCXer6lVpdEGujzXmrLNWHqRaRjKeHhh38v8zylk3E4d
 2mRnUJxR2nUmY7tG2XbizpLGIuV9jegj4a4Zaq5P5eV9VX+eOJi7ZksH
X-Gm-Gg: AYBFou0f1jo4RvW/6FA2khEGROf2SzcVGtuGgqKKby8lYK9MRV/kpfqMHNaB83x45CT
 nuA+dxHuQRmAPKkWBIOY8Fo6Ab66LDTjlHPrgDlE4/7FssblPvnMpuk1e/23eLzxyw836EAwUpJ
 1L3mEkVg/RmT5wBXwDfIpX6ODC83FHLQWaNfOzB476iAndzgvU3Stu2QOQ8r0Oxg/Svp3g26Lpr
 weeXda/1h6edW+uXC8lbQ4bU0TbS9ZO2ijjckW28d60fAv+oz/gwPs88kZweQxVr3SB8RZVHUDj
 bc5jwjedretZ6V7zx5LHjdhdR+lFTf6wE9YlSsiMBP2V9NvwR3rPbXxW7CQV93xj7u6bvZGXzhS
 SBFS4cFeK8tFseuXOHDUy52+mJn7d2TLnyTn9ieQpXlJUb3YREHZ5pUTK24+qngzOY/wfHtkNpv
 WScYl6uUdfH0U45+syefPS5apSPlHahWWZFAccphUPL7euJep7z5xiO3NB/aug0LJt+gCZfPgX3
 xVvY1/7EvxzjViLRhtGCGm/Gcom3BY0OSXdwxVSOT2gzSUYoKh7SepfnQW6KA==
X-Received: by 2002:a05:600c:8b38:b0:4a0:1c0e:b057 with SMTP id
 5b1f17b1804b1-4a1fd8a6751mr108287825e9.4.1792670826685; 
 Thu, 22 Oct 2026 05:07:06 -0700 (PDT)
Received: from deb05.proceq.com ([213.160.61.66])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a203a3e9ddsm61703475e9.11.2026.10.22.05.07.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 05:07:05 -0700 (PDT)
From: Mehmet Fide <mehmet.fide@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Marek Vasut <marek.vasut+usb@mailbox.org>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Fabio Estevam <festevam@gmail.com>,
 Stefan Agner <stefan@agner.ch>, Francesco Dolcini <francesco@dolcini.it>,
 u-boot@lists.u-boot-project.org, mehmet.fide@screeningeagle.com
Subject: Re: [PATCH v8 08/10] usb: ehci-vf: take the register bases from the
 device tree
Date: Thu, 22 Oct 2026 14:07:04 +0200
Message-ID: <20261022120704.3566395-1-mehmet.fide@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <1410119b-e8b2-43a8-bf57-7db53be44eac@kernel.org>
References: 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Krzysztof,

On 2026-10-22, Krzysztof Kozlowski wrote:
> Just for the record, this looks like undocumented ABI which would not be
> accepted in Linux kernel, so you won't be able to use OF_UPSTREAM.

Thanks, good point. Moving colibri_vf to OF_UPSTREAM is one of our next
steps, so this should be right before that. v9 will take the index from
the clock of the PHY instead: VF610_CLK_USBPHY0 and VF610_CLK_USBPHY1
are the EN_USB_CLKS gates in PLL3_CTRL and PLL7_CTRL, the bits the
driver sets for its port. The alias lookup goes, and with it the
ofnode_get_alias_seq() patch.

Marek, as this changes 8/10 after your review, does that work for you?

Thanks,
Mehmet
