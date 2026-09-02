Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BA61C61DD6
	for <u-boot@archiver.kernel.org>; Wed,  2 Sep 2026 17:08:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 10C6740F29;
	Wed,  2 Sep 2026 17:08:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Gn5C53MALcvo; Wed,  2 Sep 2026 17:08:10 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788368842;
	bh=6a8Rfvoaw8/0M9ETu4p8fqhXcAvTRdS7ZcGewnWCreA=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JRK8khLfQeTUp3gHlPsw101hgKxnxOJVBvNHo45YYGSCPY1FXiAkInVpC0EYI7wAr
	 Hr+KQ4FHNO5TKxU0Ex6+w+iPcOnpnjHwGKcuKMBnp7pRMipX7tWZEwgee3i8LH08/O
	 iTIM+3DFKBI6vqrBBGGkrQkKyJExAEMKTGS+mPqmbJZKZlo4lddq3GXWR25QJIRmTJ
	 kDb9wkvEQLJpjHQ3NWHIAVj6xElbA3tK1l/vXrSSR4+n/+r3dywvPtdjjrCwcSGqzQ
	 8jdfccX1NNfwRSCvb7c+CpaMvKFC9BEoKdvxG3hLakIEAgwgO78EEa9AvR783EYjyg
	 z2UQQHqVdREEA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 02B6A412BE;
	Wed,  2 Sep 2026 17:07:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 165F91D9
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 17:07:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id F0A23428F9
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 17:07:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PH4KdawM_lMM for <u-boot@lists.u-boot-project.org>;
 Wed,  2 Sep 2026 17:07:20 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::235; helo=mail-oi1-x235.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=sMUnciNe
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3630142E66
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 17:05:46 +0000 (UTC)
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-4b333de9451so1104110b6e.3
 for <u-boot@lists.u-boot-project.org>; Wed, 02 Sep 2026 10:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1788368746; x=1788973546;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6a8Rfvoaw8/0M9ETu4p8fqhXcAvTRdS7ZcGewnWCreA=;
 b=sMUnciNeFfjtpKjc/98XqP3ehHVqTDSlT8L5TKkWQPuHxqSB5wx92k/O+ZZQuPJnup
 vNy3yV3LdVtm4rvwHg7TSL2A29633qSUhpzo7HlAj9RtEci0y37gNJ+Zr2uEHWtWPYcD
 6IFnz2CXzIpPdwbh4bPnVqKn7+x660JW+ep0U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788368746; x=1788973546;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:to:from:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=6a8Rfvoaw8/0M9ETu4p8fqhXcAvTRdS7ZcGewnWCreA=;
 b=X8oIM6lswedlRqQML6xCTS4A3ap+T5v7K+0YgUxJvrfnf8zGW/ZZ0YRA2AuoezwVwv
 CkYHLvf3CzmNCRmxg8Pb3K5GTI6j7aOVhsroVnBfyP5pZfIY9VckQJupBd+F2ZDbFQ2T
 BTAvDhn8IOZJ+UZ/NQtlPe9/mNI+TlKgGV6EPPacYvZ+QX4d6Xu3zzMo5xUGJ5LKBcWg
 1DpCjhP68hrLCYdj09SLdi+7mt+0pO5u6oa9p6rFrEh8xaSAc1zr/hszrhltbh9CuBL6
 XD6Qjwn722jO3v/VV2m2R5WhMJsduAe1tUPDzls1aYNXAletg3cJ6giT5LgLOOrU1iwX
 c7rw==
X-Gm-Message-State: AFuF++mqciMMNmcibXL8fWrdSfeHASzkfRbLAz08bjwlguaI9632eHAQ
 j1ZSXpnvQ7tMliBVbBI/NLp3OK+MjJBThrve+ZwJ/C1epQeDEabkqliV/5VTx4l6mCE=
X-Gm-Gg: AR+sD12773yH0NIry3Li6U2s3gnzDiuEH5Jz6HCGduy3bCeZwa9Gm94pUcZaQ9mCi9Q
 taKlLimBFCMhpWdTMKw0Ezm3xXsR6T6i7VzOT4nAl4CNaVmXAVFLr+YcPvyefCUvAb4JfVRdevq
 w2MNgxEp6vYFNixMYfrExIsvuHmkOF6s53nKujmXhE6HtdMeK5teoC0x5KpXL01ex/vwANNpfY7
 IVn0VgdDe+bEOIzd/aUG7MOwXUgbFKpRZ3f25PGQeRhzXs7/axcclilH62DbA9gaedkhnov8Y8r
 6oUrfRrmWoAaUjC3eKSPhm9dqgKCABh7WqyUMdjJBc3mlVjqUWKMQHz/OG+nOuhKVj2qItJe8Bp
 2ohrGUtCcvb0Kv6dyZWJqrNSmNu3NsGTz2+H+KU8Z2HKskjc0YnMw6v472c/4jVP0AnwXYrk1Ui
 0F0L7kN2HIZ3XctZXDkKJYo5X/lje04vH+Vm32ZCpxrLWoF5HTYj+AxNF0EhIWGWbMC2VbeKIpy
 RsAW2ndTkkOHkDsYp0Ph8IC9+gxgR234FnD+3XG8/fCiUGpcai+mmmwrzVclmiPGpoZppL7TQDl
 EYou8rEU
X-Received: by 2002:a05:6808:1442:b0:4b5:5bfa:2699 with SMTP id
 5614622812f47-4b6bfcda85fmr4975069b6e.21.1788368745662; 
 Wed, 02 Sep 2026 10:05:45 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4b69851db91sm2370688b6e.3.2026.09.02.10.05.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 10:05:44 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
In-Reply-To: <20260902164006.1719873-1-balaji.selvanathan@oss.qualcomm.com>
References: <20260902164006.1719873-1-balaji.selvanathan@oss.qualcomm.com>
Subject: Re: [PATCH] u-boot-config/domain-map: Add Qualcomm domains
Message-Id: <178836874408.1779881.18004097455538224403.b4-ty@konsulko.com>
Date: Wed, 02 Sep 2026 11:05:44 -0600
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

On Wed, 02 Sep 2026 22:10:06 +0530, Balaji Selvanathan wrote:

> 


Applied to u-boot/gitdm.git/u-boot, thanks!

[1/1] u-boot-config/domain-map: Add Qualcomm domains
      commit: 6cdb5f7a545d814b4090c4988231871e56c48ddc
-- 
Tom


