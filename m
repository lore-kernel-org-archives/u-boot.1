Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390A0606A330
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 01:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Yx9T4sZg;
	dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=A3CFBeaG
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C711C409F2;
	Wed, 11 Nov 2026 01:23:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fa0shy9pMNqR; Wed, 11 Nov 2026 01:23:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 2345B4089B
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794360229;
	b=Or5Kx7jrCbT3EYDRNAS9OIYb9FtsI1cvEVscuSuNj89ols2Wbf1j/NgeJqOFB9UMkdLd
	 3AK6jz2baelrKEdv7mI/M3kkm6nPt5eSMM2liBNBI3YL2Z/HXq9xIq1JyWTlxbm+NC7Tk
	 Aupbak8N2DLdpRagQMLbKYpRGXAmhLPN18Obdf8/fgWs6ZSHCHEGHkH/G7udeZG6eJ8z/
	 6Lxpe+Zahu39+5RNRW/w1JQjSU8bBvp3OgnN2GKRtNaoQvqORNvXdWbO74QX8nw6eMacq
	 SfDc0SW2OOQGUsYqM7W/Ov3ssrQBE0Ie2Fokt508wVgyl7ZPnruBFXpA4D/tVdIyFkg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794360229;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:In-Reply-To:References:Subject:Message-Id:
	 Date:MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=7BhPOzih7R0jfYbgJ0SHHREu1URw77fvq5QaPwZ37tY=;
	b=PglrNJsIIuBV2RSCuzJ6Dipis+7y8PCKIk/H8KwKjHIyH9kIyltJdJ2dFSBw6kzpMJEX
	 AyamKPf2RBhYFEkl007VPSDXeojvnBvs+ju4eEvOxYwuEh8VNYZyjNioGwaYh3Z0kEG/V
	 Yh81iZwG0wasNr0+SeCNZ+k9VMb/p4JYUoiIJ7xRcflY7H2gsP+YqMi+gdLraUU2IITyz
	 JN9OekyG+kqzFCD7WLpg7Vz7HG2y7ncQcAneiHs9352Dax7sd9aP+p6Mxcdcw3fE42eC0
	 wN/6ix1AbY9V3RdxPUfcfBE/NIlqYh6XBTrxZ6pwKkNGmeylRf4O1VgF8FRswwjymhg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=A3CFBeaG;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794360229;
	bh=7BhPOzih7R0jfYbgJ0SHHREu1URw77fvq5QaPwZ37tY=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Yx9T4sZgvzYPFc8g6ki6ih3GWxpOadnlYUCLkFewnq27593Xys3H8+GZfhlHlN40z
	 gFM/q4nQLBZme4MlI6RS4w/d/G3KQ0GWXXRKwJuiFo8EEK0zsEwjD06egKjBgBRust
	 ityo9dK00ub2MoKQJ3U3gvtW2NStGnVE8Ft8OMX1va0Zz7tptVrUWoZxVIWp8SPq8v
	 99ZdPHP79f29cXzF/wgy2//rw7FhECrX9AOzD0QIq0UaxLn0ytaaBQ/21cxYfSthxH
	 uf0YRGnBNyG0h6/P7pIFoqlJT+q4KmL7oljUL9DyDBy8MI1mPo+/tsnTNCjCbcg4Yu
	 y5c1I35C2Xj+A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2345B4089B;
	Wed, 11 Nov 2026 01:23:49 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 131DA388
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 01:23:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0521F4089B
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 01:23:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id py3Q50N3jV9s for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 01:23:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 43F6040896
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::335"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::335; helo=mail-ot1-x335.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=A3CFBeaG
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 43F6040896
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 01:23:45 +0000 (UTC)
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-8490a7d6696so1545689a34.3
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 17:23:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1794360225; x=1794965025;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7BhPOzih7R0jfYbgJ0SHHREu1URw77fvq5QaPwZ37tY=;
 b=A3CFBeaGA4d17G9lAEOExkAoSGEE3uxzjJg+2/gx6Ivk70E0D7If5VUU2gdHp/q4Ss
 IuRTQF1Hb2XZRDvpmz8OVWUaRVSoCTMf7J7DidgHPFrWVYbFfqCipjlB1ASje3B2uiGY
 9GgbGu7KqtlIIgBC7PPaQMe/1E17laz+y/BVA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794360225; x=1794965025;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:to:from:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=7BhPOzih7R0jfYbgJ0SHHREu1URw77fvq5QaPwZ37tY=;
 b=aLhXtdQ3tTTrS2GSvjDPSOkCgxvyC/OcyDF1y9n8i7DUuP3zWSVh9CmLfCSwnXX88N
 WWFDbBtkW+uw10fnJNMB0YHjfWl55mWKCTq/hUz7U9664x+yIlpk3WoCGJwhUYW10SbA
 tHpq34rIcLIkSQDMV5MvIeD/6RZJpiq7Hsvwi1nJzRAYXYLPAJ4amzNtQsnmoladtd13
 cx1kCJRYH4xAoTF88gZOBo/Zo+zi/DEGrWBu8ZIn67kkXveK/oTgt+1GAf+xbJPv/bEW
 b4HARz+lcYtqRg8dowcAmwWkrRLs2jlzvDhRZStpubtUwLcayPozl5A1rpi+F1sm6rNU
 AjEg==
X-Gm-Message-State: APuU4Z+Tme8YV/8KgF9S0UVAIYaL2Ptx3DURKbsZ9ym1oN6btqq6IQ5A
 VwvMLLOM/vdpJZzdKopUV5mkjk/mjVipD+OAuahw3M1EhZ2cmaqDZ7fu+vEDeSkD+eJL+83wQ5c
 ehmr1n7ZQkbJE
X-Gm-Gg: AYBFou3MoAgooBwDsybMlwbAQINcOGOD4kB4zoIR+4fQh6vJhONn19P9iEAPZceMIUz
 v6iQdXaFqjKUCAi9VfahQFM8FfW7XQyNoeQaNp5X5xqdU3+14Itr0av0I+AkN1aW6bdtFRrqUw7
 Tz+kw++URsdZfo/vnlM1Xr1PRvDqEdOVhww6AKl3eWt7z2IaZSJzIZYAFkNdSFTofbqcaSSi+qS
 lT9CvnqZr98wZMqnS5efN7/oH2b6QoH5jYnVhox+/yc+K7b4f68CPO3sCBK+v9Sw3tXvV9yht3U
 IQDgUGNcjI3P5Kx6z/9XZ6rvBOCagUK4InVOnQ+Ckxulw1MmXhv+F/w3+90hy+91sSAekoxvxY7
 IAjG7a91QUUI2RtHajvHAPWIOmD/2aVjyT9aaWf26kBXSSct1KeMcV3k3WM0pfMcTj5rqgLoia8
 uTfi0MsBO4nWj5XzVlJr8+IjSTRa+0lLO8LhTByJLxQUQ8cCeGXVSujQ/1NmeaPOtQn6Mcw2uXx
 IQcnYKB+iN9arZTpmVMZJ48ja+0P8uSxNwRO9rvpoAyx4WCurSJnCeoOo769htOxyWViUF6FuDu
 kzrF+uK1DRMVHmyZRifmJDXb9JU0A89uCpiYWIigUnrFUvh3ZRa14aQybU60CWP1f5roSVTkmCn
 qiQmg9U8qOatIury+81V9bmHZ8iXEpHPqNqv12S5/AD0lvuxnhCZwea6lh0RFiqwqPCxVzF8PVk
 FbBgZI5AE3DVYgHHe4cwe/4VmYXjbGLKE1eZUJYe/sYofhBQ6Qwys=
X-Received: by 2002:a05:6830:2b20:b0:846:7d51:d9d7 with SMTP id
 46e09a7af769-860f29155eemr609293a34.28.1794360224679; 
 Tue, 10 Nov 2026 17:23:44 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-860dcc005f2sm3128606a34.22.2026.11.10.17.23.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 17:23:44 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, Viacheslav Bocharov <v@baodeep.com>
In-Reply-To: <20261109153405.50010-1-adeep@lexina.in>
References: <20261109153405.50010-1-adeep@lexina.in>
Subject: Re: [PATCH] mailmap: update entry for Viacheslav Bocharov
Message-Id: <179436022344.336966.3217846524556212559.b4-ty@konsulko.com>
Date: Tue, 10 Nov 2026 19:23:43 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 09 Nov 2026 18:34:02 +0300, Viacheslav Bocharov wrote:

> I have changed main email.
> 
> 

Applied to u-boot/main, thanks!

[1/1] mailmap: update entry for Viacheslav Bocharov
      commit: 8ea02c99391d2d922810065206721ead2863f075
-- 
Tom


