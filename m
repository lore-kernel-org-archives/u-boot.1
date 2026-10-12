Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB600CA9EDC
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 14:01:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id ADCC880DC3;
	Mon, 12 Oct 2026 14:01:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zBluJN3pUE9U; Mon, 12 Oct 2026 14:01:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org F03A680DB0
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791813670;
	b=lY4II3M9vW7qgNDkThWK0xX1MixWXi8vP4pchRV1mRGrSbQEhgnyxfqr9BFrt78yBgxy
	 PjAQTEHBZIoxiEpMWtiJ0nYkXoU9FR32aE1ybE0pK9KRSxZZuoDb9x0m0zmK8ufEJpEQJ
	 a4DCzM6gg1pY5wu8HMEJj/YbOAECm1w/kYPWVJuV2CuqhP7OLNm9ZQJdgH8B/kqb1Ynis
	 wBwDBXNh6HHO4BjWFljn5VzYp/7A2/oDasIUg0zpayWMt7N4aG8TXb8nos9384wzpc9+V
	 RPhvK10bcMwPXRGc3C7quieKhQ7fFt0YrfAHN9Css/ziA0UnsKt040OIaXyXsHrobVQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791813670;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=afzLNemZ9BnwP+jnhUnGmD8FCTofIYCNqHjd+AROSF8=;
	b=nnJldgq9yQ1sxLsnZj+8+5OPJGz9BFUorcFr2ms8EscHrX26vFvz67Rn57NntzBaq7iN
	 r4P2bvpAzEuvtdPanqD9+S6NGeb7gj2jXrq4BwXU0qBr1O+Dg9shI+yqXEHre5R93N85f
	 Hc4H2qzyR2Xm5MIQQbSu/pbyYm67sKfqdlgAj9gzAv4BSee0aMQGyOg06TmoPIcxI+sTh
	 6rYjmfUhRNtIn6zm7UsZcEOXXJ0gUA281tygMibe1YCfWMzlSSstehacFOWm8zvV05zGL
	 t//PfPC6yErz0XViqygR22mi8GVofUoaFcWYcWVyk6Q+LvUNrIXxKrhu5T+wMUHVhUg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791813670;
	bh=afzLNemZ9BnwP+jnhUnGmD8FCTofIYCNqHjd+AROSF8=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=HulQG3G12oZOtDCNe0rilqxBBBjKUZZXYqLwsqjWP6mqhgJaKZyjoeRKsRusovGDw
	 PplJgcQaDtJZhMmvw1wWG0tZXpTlw6qFRcANQcleZZu5lsAV//iof9v84Z0biMczhm
	 SGv9nOJBGr3o337k4Y0dZ3enz6dEROk3OoRNAyjJBUQnQ076svBTJQAvT+i7tRVVr2
	 16lzM2tcg3+G3v810yyLp/J0evb4vc99mnOI1WijCmZpPqxUWOTb3dLxaf7Jzf3d5l
	 TAcxXDh4Y1mazJh89ZcApf+IjKaYtsqMjhrNYtscoeJefAVxlYQrI/LvBqAVIhfxaY
	 UI3ANVgDzxl9A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id F03A680DB0;
	Mon, 12 Oct 2026 14:01:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 584F8156
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 14:01:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 561884059A
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 14:01:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VqZ7GVD7n65f for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 14:01:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org ECF7A405CC
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=185.125.188.123
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791813667;
 b=lhqroumewlcOBqa/V/i6ebbqeSBKrLPBEnJ4ubQoF6RiY8Mkxd9gMoo/zLimVUKV9FyD
 TEsuapC1IxPxjlPUbmBUByIlrHSpgvsr6BFFeVQ4faje+M/88akFgnIGjJFw/RBOx5/Ov
 v+LlmXY0vHBLNodDQqDTdrU1GpPVvhtI4SOhIenTsJk6as0uwHnTzcj1Vg3v1iLkKiWBL
 7rvwY5fwGZVp+TZs2jmNQC0Ha8PsuLZyP5cRii1OJqCKVe6yOv9hF8wukIuRGOZVjxiy5
 GT78AlsS9hBG/hqWYiDBTOjNIYDdTcZK3H3puXN5FNo4gsTEeDB18XkIau9LjIWj7pQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791813667;
 h=Received-SPF:Received:DKIM-Signature:Received:
 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
 X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=afzLNemZ9BnwP+jnhUnGmD8FCTofIYCNqHjd+AROSF8=;
 b=CDTlMmL5FZf6fM277JU3rqk1sLeJySvkk9HGhRlTi2PtjyJvGM0ZD0CLhm/kqGRzsujl
 WrWDOZy1QRoVo9y4y7qALaa8YxPX5Ej+lrBgVLq8C4rG9qqdPuoEzrZFtNj4UbZDAMnlL
 JWj91a93nMuIKcu2L+vAATbroeSQx4M0ROX6I4kT35aYLofcejHky4ecWEfl3PekZa4sN
 o8uYPnSnuC8jaWv31hT6Fs/Fh2SG9fPE0ZHM0cHI5tY0q5o6wOtuZnrvq9ixKmxVRuHo8
 QoeUnE1eH7ECE6IR3BF3po72QgXeOK37yRkeqEyO2e4rj2TvYlLc+foj4Ci1cAzMIpw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=canonical.com;
 dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256
 header.s=20251003 header.b=HH4pJdLW; 
 arc=none smtp.remote-ip=185.125.188.123
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.123;
 helo=smtp-relay-internal-1.canonical.com;
 envelope-from=heinrich.schuchardt@canonical.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (4096-bit key,
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=HH4pJdLW
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 by smtp4.osuosl.org (Postfix) with ESMTPS id ECF7A405CC
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 14:01:05 +0000 (UTC)
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id A47F43F13F
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 14:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1791813663;
 bh=afzLNemZ9BnwP+jnhUnGmD8FCTofIYCNqHjd+AROSF8=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=HH4pJdLWiX++qnqv6I58DSK7BCED+CbO3y8g0tTRqiEdmNlEV/hZoxpSmApLTBimi
 AsToNG9HY5arAYOesgRBLNtRmv+bjZsujrCkFpBxftZG/ExFjR6SIqTm7qScSBzoNr
 ju1EvRd/X2pCFMd1BJvSOKGnbX7Pssr9GuFHCKYJ+hvrTaB+bOcgZjrhEuCS012/eJ
 y2Y4HS3Iq2uywiGKMmJHFphEKpg7pVu/lXZr6HNvBG4Ae+1B5D3Ainbly3pRmBg/N7
 MgdrnnNhqzVJOUzpNvjU0RTabNcngvoYRH8algsjknplIcG0P2CVQye8VRdj2Z9/rc
 s71bTIQRoljnk0qWj87x7h86B5qpJgUN4uPsqQq3BkUSGs70wW7yqvSjRVk9dX+rrv
 A0fYMRojG+edEpgO8I1nWQuOz7BXESRE2u/nPfz09WErV6096ZnH1cAHPTMhFeOfCg
 +jWUUdeglhAnxf9I5jAzq++5BbXxi+z/Blpj/9+6yCt3JsRrI5OaMPamuAGNG3VQyM
 ghqln3TZ9GK1HX1OfiQRxdzs7lvjfJoYh2U/5BkDpolRHeNQ5/yJZ3ZQp5QRq26pm/
 KIuzwGFGoKxO6lAUQwy5NpgUCHGjNtdy4eg2QWPNVeGn/yw2cw8Risb+yWeBVWwqVZ
 VaeZ5XQDKwBLpRH2ls1TTA/Q=
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4a022fee32fso14880065e9.0
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 07:01:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791813663; x=1792418463;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=afzLNemZ9BnwP+jnhUnGmD8FCTofIYCNqHjd+AROSF8=;
 b=Dy9Z0OGWYZZmjNXzdMsArx6QMQzn3GPjHYGLbInoBCAPC8IUJ5XH6vw3Tqm+8jzH+L
 qGt9RaJkGu7cjBBN7vVlZMEEz2CesmkjgsGMUaN/sVHdMDXoK+pAWF8aEAjWpEwnKkLD
 hLJmokzDzJJQudaF2JQuHJYg8U1hbyXd7AzjGDvuANNjSUhsJ60WhdZal3WZgZrqK+mv
 9xCb01NVOwaETHRBGQJgxQ9vUgxageLf9ZlcROJfz1zkQRNY+DRER+HSp5GaMwyflmrG
 WADratKUWLV8a1q7LQ8I8P9VDdZOxPqwlHPUlGbT25S+r1gCIZD9KUWr4P63e7NCS9vj
 Qc0Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBxbr1bCV+Y4Zls/dZiAvlkMpL66S5yag/0zjchc+no3wMyWhaGdv+zJXa+0DtWlpIQWsOcbYJs=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIdGzVVz48bjUwotmkqFOE2akluL0HO5PXjuIcgLWgANAsTlXu8
 uCIszDmWgrLJSVA70Wvgb++IjmaIWQiL6+YFZUnGezgyJRPA2NYFOzfSv3nFtcc3C0MHgs10IGc
 N1swqrm3nZGy2k9mk/0mQg8A3TG/aFZokTrV2hv2o/3NcExqk59bhBoTYIyeC0tW2Uj6m5GOXAk
 RtP02yL8DHQw==
X-Gm-Gg: AYBFou0QGV7iwqjfpElpPOz9ZA/GXBiDdtuZORmcNGtDOcbZUjrcYu5is8RkuhdIP+F
 Jy5PU5zGn8tv0Qpc5RCUUjCYQEBRu5+Wr5L4XifNGYKejpdac75LUfu2kI3kwHkIYWcq9zocaWI
 Bnos0rbxy0GLRwJZ0qQ26hHMzE0V9dirbdgH3dtxy+RqIIpBMPrrlDnHOZFZMLr5LhQEkfATp1x
 h55chJ3VZifRDgZRLWA690Z79jLnFqEEz5eGtdXqN/bnk/pPTtzFz0QLtT+2+BnQssTHNIsHPYF
 4knAi+lIkFvhwxHHKJoH2UU7LmJIizhccRIP25ZeQ86xhvXwcPk+gKO4VUszCkWDAVEyEH6++Qx
 /iIzx2rBPsSQLOV6mt380NNc7dlat/H+8rTkdYFKMVUgPKJ2aWTD33zc=
X-Received: by 2002:a05:600c:3ba5:b0:4a1:70d4:c69 with SMTP id
 5b1f17b1804b1-4a18e4c03bbmr210746025e9.28.1791813662885; 
 Mon, 12 Oct 2026 07:01:02 -0700 (PDT)
X-Received: by 2002:a05:600c:3ba5:b0:4a1:70d4:c69 with SMTP id
 5b1f17b1804b1-4a18e4c03bbmr210745395e9.28.1791813662399; 
 Mon, 12 Oct 2026 07:01:02 -0700 (PDT)
Received: from workstation5 ([2a02:908:1242:30e0:468d:767c:32e6:22fa])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18bf15691sm284551015e9.6.2026.10.12.07.00.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 07:01:00 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Huang Jianan <jnhuang95@gmail.com>,
 Daniel Munic <v-dmunic@microsoft.com>, Tony Dinh <mibodhi@gmail.com>,
 Alexey Charkov <alchark@flipper.net>, Vincent Jardin <vjardin@free.fr>,
 joaomarcos.costa@bootlin.com, Aristo Chen <aristo.chen@canonical.com>,
 u-boot@lists.u-boot-project.org, linux-erofs@lists.ozlabs.org,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 0/9] fs: improve change date handling
Date: Mon, 12 Oct 2026 16:00:39 +0200
Message-ID: <20261012140048.214059-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

* Let the ls command print the change date for FAT and ext4 files.
* Correctly update the change date when writing ext4 files.
* Adjust tests.

Heinrich Schuchardt (9):
  fs: move struct fstype_info definition to top of file
  fs: print change date in directory listing for FAT
  fs: ext4: print change date in directory listing
  fs: ext4: don't read time fields in XPL
  fs: ext4: set inode timestamps on write
  test: Probe RTC early in dm_test_host()
  test: fs: allow optional date field in ls output assertion
  test: env: allow optional date field in ls output assertion
  test: test_erofs: adjust expected ls output

 fs/ext4/ext4_write.c                |  45 +++++++++-
 fs/ext4/ext4fs.c                    |   8 +-
 fs/fat/fat.c                        |   2 +-
 fs/fs.c                             | 127 ++++++++++++++++++----------
 test/dm/host.c                      |  13 +++
 test/py/tests/test_env.py           |   2 +-
 test/py/tests/test_fs/test_basic.py |   4 +-
 test/py/tests/test_fs/test_erofs.py |   8 +-
 8 files changed, 150 insertions(+), 59 deletions(-)

-- 
2.55.0

