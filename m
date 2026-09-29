Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7780CCA5FAC
	for <u-boot@archiver.kernel.org>; Tue, 29 Sep 2026 20:32:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 234F280ED5;
	Tue, 29 Sep 2026 20:32:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id n6Nrx2gTQceg; Tue, 29 Sep 2026 20:32:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 78DA880ED6
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790713963;
	b=skh+cfJ+ksxjIb6QlzH0tCk3uBCZVKI2ufBzlk2mMZdF37fK4fHrtWd18mmuqd6M+C85
	 Kj5pSrpcRz+Yq0m2SJIdeASIiMCOgxWanNljdCzK/qKgRikjuGt1O3dGBIRecm1BMEO+c
	 Z6QOMUesKfH+9QStIYxC1bzSyRIP3+iC2evFj24B1YTCjeUP/QHelYaljFBWqDCEP2ipu
	 KKo8YzZLgj7qZn0xELO/pt/nL9+eR7vhMIutMZbWc3HH7Q4Sdn7I8KFdQJYRVDoLnN1+b
	 Cesxm3qrX86dwm4mjs+Nhw2u0m9oznNwKl4UD97ePIBh15Be7lZ9h/jb+kf03ggqBZA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790713963;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=i7uNNuH/QSLP2QVczGWyuL6YTtg+5TLJiNAIip/0d9A=;
	b=I5cDpY1TP1u0UPcDQNTycNXLJq2Cm8RIwPPb531Ge+z3g8ieeeyDB4wv/0se2BMMyN5e
	 FwKrYatY5uXUc/BiRrMMeDfnn9ONSrxLOWl0K7TXyg+q7LHrwVBHnqTUkgiDXHfakNsd/
	 wnqZKvIeL3NpPouezie0jDq2t5ZLcvIrRn828ILQDmUprDfrw9XLemSmfmXIb2E+IEBKu
	 KqwD+p/bCHqE8/kYvqCTG2T/Tp4KgXKmz3hvPtU43vrwFgmlYlreH9CUgP0MJn2u0raGU
	 fdQ1n5KZMMwBehfk0FA3Vfte1oei2ZZMSszeYMstucDxRuqKnud9mhjBkgMQEnrrj3w==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790713963;
	bh=i7uNNuH/QSLP2QVczGWyuL6YTtg+5TLJiNAIip/0d9A=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=0eIRTHFL91kEEThhw2EhGggRc7O1vnDKNws/4NQgsOqBFnpPCV63+311Ta9Bm4Ypo
	 1f6Ar61LSmP1JpTnhYysSBDcCH5XDwOdTTA43StYxpW2buCiwVZvFoQc2mnDpMeEBY
	 JTk6XwgDRBht//ezaGIyWSfeWpNK84WbxDFdqKDFiz3XzMSQnIepZfyqK1GiJRb6W+
	 xV8Cd+C4KEoey6p61K/OZz8gpdl2pfdq1HlR4gUf0uQJyXfybMg1ATiA3D0Y+BUKqb
	 +jGSyazUi54aOGPXdNR/7Wk1iAxeoeXHwqv8EZTEiixGXeyBWNa7gT9quQfCaEXf40
	 pDTiSPBMrvOFg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 78DA880ED6;
	Tue, 29 Sep 2026 20:32:43 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 735C014C
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 17:59:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 65244607D6
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 17:59:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SuqQ-jNJs5Is for <u-boot@lists.u-boot-project.org>;
 Tue, 29 Sep 2026 17:59:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 9817B607A9
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:34::d"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790704781;
 b=gpAgI679uYyTxLbeE45KczfmQfvUhF5HKhNnGp6YhEv/rWbg2maDlK530fzm7qa7N5yn
 p4lcwy5JpU1kTbkHaZfkpCJ64XdH9446W7VcQZHbeZsnrB08dQL3Z6DciRDWHUIkVbYYq
 xr5oqWA/7uKD0XY4q8f5XGEpHfCTtNJxys00QC0ITx36rvS1k1KlPbnxxqSn3HNyA7Ud7
 vqVbOXyyR3raWbhP2kQPqy8DNfCuR0dp2Co8+xyNz6/iCOCop5F8qrhUen0w50iMTpYju
 x32lsRaq8A3Ad+IUvAfOhTWOO/zCL1zjc0L14rIdMIcXWsCJR36BRpV9rU5TU7SpfEA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790704781;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
 Content-Transfer-Encoding;
 bh=i7uNNuH/QSLP2QVczGWyuL6YTtg+5TLJiNAIip/0d9A=;
 b=osgJp1JFhgVVFF10KdZBrlwgqiSe/dmZPhf8zsnO7evG0KBu8xnsPpcEasnoAmCVVo5Y
 SqXDSbnXqkUMD0OR4hjwzCToPqh98F+Hl4I+q3lKx+v4M0nJpvERcojImi6itKI/Uvzz4
 jBLP4E2M9c7DKKF01jEcG0zfBoMfHiL57CV80O/PKaV9zPYztaTbqz+iLWppnTNBUzGwc
 i/hwI22NUVAbIEXRpJ/nubGxhtA3+jv+MXpcMunJwWQ/ZzE3vVmPq8S0aL3teGbCMTZE1
 6l6ntNgEHbHimt2vJr25zlmQtiYbPPb5iXnDXbXzqT0vRQXV8G9DPtqPuwe7ZiRUt2Q==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=brivo.com; 
 dkim=pass header.d=brivo.com header.i=@brivo.com header.a=rsa-sha256
 header.s=google header.b="N/cOnw7h"; 
 arc=none smtp.remote-ip="2607:f8b0:4864:34::d"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:34::d;
 helo=mail-qk2-x0d.google.com; envelope-from=sanderson@brivo.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=brivo.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=brivo.com header.i=@brivo.com header.a=rsa-sha256
 header.s=google header.b=N/cOnw7h
Received: from mail-qk2-x0d.google.com (mail-qk2-x0d.google.com
 [IPv6:2607:f8b0:4864:34::d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9817B607A9
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 17:59:41 +0000 (UTC)
Received: by mail-qk2-x0d.google.com with SMTP id
 af79cd13be357-93c59695cc9so301721385a.3
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 10:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=brivo.com; s=google; t=1790704780; x=1791309580;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=i7uNNuH/QSLP2QVczGWyuL6YTtg+5TLJiNAIip/0d9A=;
 b=N/cOnw7h/fzH0Hn6DT9v2ihZRjorKXXukJ+Z/ZjWn8odBU5e0aRnHsXjmpSMQr0NNU
 POfKIoimMY/tyZlKY95pNQDSlJM+qRRHTG2xv/D89BNKKMK5Uulg3gQGBKkvXTOMS9Fg
 ahct8iqymb+0G2YXig0xoxlXZmZkIOZAA1t5cdwPKvbJgCgp1ZllMTYfsYDMKMKQGCW9
 vp47cRZG8grmBnk/flC/wX5HifRXp3JuMhkWxpyYHf2f2jDRXLrw7hLqq5Z9D56U9Ojh
 o7LyW6xefvZmWdXcGo5eEEaYc3466y0deVJAksrCXVkCbsY3wyVXOjrRb3wZ0NDxx8n1
 DFQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790704780; x=1791309580;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=i7uNNuH/QSLP2QVczGWyuL6YTtg+5TLJiNAIip/0d9A=;
 b=JLJw58XSo8uoHBi4LOpqko3aWIBtw7PRZK7OcuPhyD8F1N9n4JV5h6DGcX64SXFGXG
 Hgqk3SeUnXsIhnBdFBGX7+MeHgt6w31WDi5ABz4UqIszEW1FJGMQ46D0rOhfrOaWyqnc
 v/ISiytgj6LF7Nah0ZbEHS1PTB85tK+eZaU5qoUcKCX663zA5o/Ya8AmFxT+Zi2NNiW2
 iArgmJqs9tr7SgNRxhz4iJaA+1e/pvKDOwAxAgEnQUY9ihKbF0L+JxmgiaHw8AW6wtBg
 62HcIiwf97WVZOieRpNPRKCuGjGKIw4qda/pdmUw8tdk6HWRlF09swkAjKHoo2VAQuR7
 Rvpw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzabaoR7QrCG2/R/FcHVA4uCS08hpTEGNpxwYiN6MCC0/wlJOP0WpBLH58YAvQnIwBhhIlqu6A=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nt/jnSb++mtETfnzA0UsC7T9+vAF58FR6RfXVert5TU32TWE4f
 DIJ+iUWon+UuZ42fMXNCCvPBWFAUke7PztVjVb5JznFvosqZNw/9zKL7KG5+teT7tLQc4JfMbw9
 9/iogi07hatV/LyR1bUCTH1uDmMc41wV86G7cPG+0MgjV+T0O2FATVWmphvzTkVC7UFznCpn6wu
 zaee8=
X-Gm-Gg: AYBFou1uMhVgpmyloToeOOAU1iLHcbqhtajYrNMne8+QZrpLRhIrBnd/oOCXZOD78mn
 Fswyy0lsDIEYeQRajddaKvKxfRMK9si+Md9T2WKBgoHCjXtarcD+wvvUpkz2eyrvrfBSi4Wc/2B
 NbIzmX62lsakk2E6cOQYlGbbdaCdcw/9svnsvma4WXmRbtKisjZh9UVR3lA8PC1hKzHcP45nYHv
 xbqWLuVSf3UJ4uLG4LwRSuCEG3dOXdD6De1MiKd6ZBrEqdoz0uVTySaJAnrFBBUT+afASQLrkBU
 hgcqWoRrP7WHFp+ga3kzJjAmytqqxyFZba6tJRVb7fWI3/7ZNclT6+X0XFXLl3HQfS/wKWmd6eC
 K+saXraUr09o6xUKfgci0XUUWtLMxqkLrIUCzS0Y8hsyPRhXSZPmozOpu1fS4W7fkGSZFlUnGtY
 wuNt77X4j4JM1x/PmfHOGx2cmpVwEbqLtsnMwQh3O3m2bJ3ShSdMA34BIttWWS/U4=
X-Received: by 2002:a05:620a:26a9:b0:93c:b10:7243 with SMTP id
 af79cd13be357-93c9f93888emr58784285a.5.1790704779798; 
 Tue, 29 Sep 2026 10:59:39 -0700 (PDT)
Received: from strozzi ([66.193.28.125]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93c9f2dd65bsm29923685a.2.2026.09.29.10.59.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 10:59:39 -0700 (PDT)
From: Sean Anderson <sanderson@brivo.com>
To: Jerome Forissier <jerome.forissier@arm.com>,
 u-boot@lists.u-boot-project.org
Cc: Bin Meng <bmeng.cn@gmail.com>, Tom Rini <trini@konsulko.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Sean Anderson <sanderson@brivo.com>
Subject: [PATCH 0/2] net: mdio-mux: Recover gracefully from bad parents
Date: Tue, 29 Sep 2026 13:59:30 -0400
Message-ID: <20260929175936.3374213-1-sanderson@brivo.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 29 Sep 2026 20:32:39 +0000
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

This series fixes a few bugs I ran into when the parent MDIO bus doesn't
behave. You can reproduce these problems by running `mdio list` on a
board where the parent MDIO bus fails to probe (such as if there's no
MAC and NET_RANDOM_ETHADDR is disabled).


Sean Anderson (2):
  net: mdio-mux: Don't crash if our parent never shows up
  net: mdio-mux: Remove ourselves when our parent is removed

 drivers/net/Kconfig   |  1 +
 net/mdio-mux-uclass.c | 38 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+)

---
base-commit: 2b8902913c19eb581fb0d567201c09b8fa46ac74
branch: mdio_mux_parent

-- 
2.53.0

