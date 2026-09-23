Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98C40C98302
	for <u-boot@archiver.kernel.org>; Wed, 23 Sep 2026 17:03:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CE7CB605D7;
	Wed, 23 Sep 2026 17:03:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tSo74n31DvQd; Wed, 23 Sep 2026 17:03:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 4219860880
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790183025;
	b=NdNBkkUlQDhBBYyELH8yRyYBD98hzaMcLYpgq4Lca8Adnf1fx2jPoS1YTvdxs8gIA2QR
	 ibhCo7Q+MUjZvUR9Hw30ThpGwikzHcHzdH1kw2Xv5AqyeV6niAlQNKKdKa4RpVCOON2Se
	 mPi3ZnNMGdt0b/s6Wuex/NuKv+5YLIug4HScuHeOK8EmezjQj4qm/IUQq/TR0K6KtzQxi
	 Yu+jNl7Y+siRVqA1mJzIBo+29IYIwCu6bjCKjB2sjQS6YmPnQgxE5mujwUbP6hdwJWKSG
	 /DxT5mbUOemV9arbU7hH8twhFlWi+cYt5svP1cWDcih2Vku4F1xcv8yGNiM6spldBoA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790183025;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=DWeKndj395ycIgHoqVZzfddonfFEtPYGem9geCWhGtc=;
	b=SWhRxtATCa5tWQ3pr6maPdLQs76Zr4fR+ire3mP+0KDQBfXw5Xxhfob7yYFyEzuz0lM6
	 UM9EJrIJQRHc+hYvhs0tKEi+sy6X4flv1AFNZPepe2c7Bfadvk45FzPW/s/u0kTfWbIJw
	 Hbwy2pdA4iN3j5rCdD7u/u8QpAApKwNT9iY00UGZDtb07ANePhI57YwR0CdItR8JNINYc
	 DSbCxFXckfYrP6drMDVSX1DxiJWpaEOrHFBAbIyEyFgoV2mt8++l4mLgZ3SpE7bSUPIId
	 Iy/LI88aPeVaHYakoZHFyrLukxufexss+jecnBYjIgpX1M5xQ/aZvEnKLt1amRTCeFA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790183025;
	bh=DWeKndj395ycIgHoqVZzfddonfFEtPYGem9geCWhGtc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gbjla60rlu1faXMLYLjpgW8Vu6hDTSYjRZgueGgnTJYnomhGFvXlAsVnkejGgW+ms
	 URnV2jFICbeF550jF+dXxpiHEpJcpoadlHC0KnZw4M5fX6icfjYNUxGhi5+XFvXzE7
	 kgmpRnIGrmzMesx5FIWiXS008n7G6TLUW5ZDlN5887zsH08zsEoFmDuaT6Nx5I85gy
	 3CfTLqWNiAdtGA6GKCq3CsnjrVNGWJWe7gsr/UUzzSWvjnxGZYJWnPGsel34MArERM
	 04CKhSUbS3NxVN12TGd3R2y8r5ioopg9DZY/2k2PdSR0mnJdaUVCmglwy54jYWGvAj
	 LACON4jz0956g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4219860880;
	Wed, 23 Sep 2026 17:03:45 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 497C5334
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 15:46:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3B8CA40348
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 15:46:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id szEesBH3xNVd for <u-boot@lists.u-boot-project.org>;
 Wed, 23 Sep 2026 15:46:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 4970840282
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=185.125.188.123
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790178416;
 b=lcoAHJPLqt5/VX+8iFVYjgkcG+YaEWScFzRJ6nVpxlqik8CbiBOqwJ9bNsrvX4VSqFDN
 izGEJpoHTTa9SpXVINEICB940FnJLtx6d/DvmQvvbXwKyJKxD6xcITh85mq4yC3hYyT6y
 ZoKMjB8NHtH9sabPGXy2A8qXgxpmDPYCppjTwYIFryMv8heYFlGsv/SbVrqgTiUY6PYSM
 /3wKOgR2hq8L/a+D5pEd5vw/QcK9/xvPeyRHP65SwXQhkZKbDZIaxXnYaU9m38UB2yMk/
 ES7bt/GVDvnoW//d4lJichFYFfdxJA0dRgCkDaiv/Wv+NG51O5Rbfu+Dxd0m7cegLiQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790178416;
 h=Received-SPF:Received:DKIM-Signature:Received:
 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
 bh=DWeKndj395ycIgHoqVZzfddonfFEtPYGem9geCWhGtc=;
 b=Dg/THTipB5w2lP3DpEUSYgA34oHSG+AgwxDqSjOs9DsmN1ylNhdC4q+w6dz2gO6jREEZ
 /Jh7gbnAaAZrPyBKV4eUsJWmU3SMwZa2pLFOIz8vGiUW7Ahn5YUQb0vdcKL+mzoHSQQkf
 tlvgkIavwHJOr3iQNjERgmC+Yq+kjGRK1/sP4yrnvG1HX2cZBzjfcciEEiDh4HiEY9Q18
 4MSfXFiNdfHI+vM09euqFv4d3q7onuvM4z/1lHyA1KUWaYQ5maAle5t0G3qcDfofNQNN2
 m9d8GoM3J2svucHetgmFaULByZUHqdSJSi7AD05y/jxgx51rQqAhKNQ36I8nxqTutmw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=canonical.com; 
 dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256
 header.s=20251003 header.b=IpZZFfD9; 
 arc=none smtp.remote-ip=185.125.188.123
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.123;
 helo=smtp-relay-internal-1.canonical.com;
 envelope-from=aristo.chen@canonical.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=IpZZFfD9
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4970840282
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 15:46:54 +0000 (UTC)
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 3058B3F322
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 15:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1790178413;
 bh=DWeKndj395ycIgHoqVZzfddonfFEtPYGem9geCWhGtc=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=IpZZFfD9OgKOh+rz5a+ipzmAi+F96BgA8kkrwMnl2yaBnkz1V+hyBsvYXRnu7Mpgu
 LuoeGXpi81iVmTweASJGR4Jy5NGf+1UdiibPzh+k5f3fzW+53/4CWqS9C6Q1c+L2kG
 bZ79pYmqYXftXnQI/t2TnVoBPkxpkjUHr+XpPmM/uJm3LLGYAE+0Q3JstvEUiAclL+
 8ZBuGwmM9Yoc+ms92fu8pdhLdTpxzOCHMfZMN9g6eBmVnMDgPfkUTaxkvJlWJRue29
 KE+tieYVWyXbZysvfRk7Arp0u6E+pfn5vE0d3I+m+OaIxtxpfXJTQzAGmtbrJ0xOpa
 ieZAf3jwYDFuXgnY4sUGPik8VOlN6TRw59dBhCbqmOl1ESPlviDukxaC0ek4E+c8RM
 krZqh3OYb4XhK3VgOHAVXEODYPSSEO+6Vrd7D5Xj7pEuRSRYGOi+dLNkvLYCpBLEbt
 Rn23LE84ISuIUK4zxSVSvTFZ6ocur3qxnXsLbdvQ88PpNLZdgJ3qBRxgRv/HEZgzW3
 rd+fVYMv8USRwyTmyp/WjJBdAp7tsd+004OdHYCZghPTKt77cisnRcylAdmStcKJTL
 g3Et1VS/vvb0CZoG3mrWoTdvO2HMMPWjpmQ1c9BEIYH3RINCBMtODNLpkx5OhE/zHJ
 Et9e4QE/Z/K2+UBuo+a1n6yk=
Received: by mail-oa1-f69.google.com with SMTP id
 586e51a60fabf-46509ab0149so1316338fac.2
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 08:46:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790178412; x=1790783212;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=DWeKndj395ycIgHoqVZzfddonfFEtPYGem9geCWhGtc=;
 b=AmCI92wlnHAVrWDen3+/qZyS+2ExZBoq0jOf1HJvy6aIuE8Z5vA/2R7ICfZu0jyOfW
 n7WBPJ6ErRA3tLF83zSP1nj1vdlsQ3GnJHS1A/Q47HDvUF982jABwRJw5CUqi2ja+/1G
 oTKfaEwfdiTthNuctMd9obEf2FMNQ3+f7Pw6/1QQiOs9v6ARtzYMXh5LcISs7mdvI+v5
 ILg5OW3RrkwbNr+j+2I0WuNg8vW1zveD/TdqeyDbf6dBNYwAV4hVP78l/+FByko5OZTD
 oQHL3toyfpTlhmcH4ou0KWfqZLVmdouuI+sN8t0LNec2v+UPIxnEt6QDS+VqdK4VnOdd
 4Juw==
X-Gm-Message-State: AFuF++mG70xc3AsgQyCq6Hn2Lzml3EwP4/vF0GiI1Ttzlqak2J2EX1vj
 o4AXNdfx0UHt54iVelAKjDkhgRur5bHWC9DybIahBONR2zcXks1rgIV2vdtVFzPxuMKqIyjzL8+
 0SdD+7uEUhI7CwgAv3zSoPFg/GJA1K6wWtOo0O7x1T15VfTpqBZZy4KaUGwEjdUDvgHrTgrt/eD
 vB4vj+gl/WN5ukq5yqOw==
X-Gm-Gg: AYBFou2XM2+GZna+vWQW2gkE1xCJZ069ZkIfzwoBx5vLSu7uhr/zoUQ0Lq9seEDyBP1
 YLPLyhcYefgDJY6CaJE1gVrRUAgu3s7+OLsUT5M5FK999oYYiMP2cAJD0seuxKHpQ+uwPR+ibF+
 S6hwPxg71EtAu5B+1hL649PifeVvDOYZfRyrk8SDUPzwtPvuFeyBv84W2ZIrChgRpGeDRR1A+4X
 rn6FvFB+TZMOKcMA6imatispvGhtzqLKW4syv70CI0w9pV/gCuCUCibKJYqOwqNv9x3SAEVGNL2
 t/lEatietPG4tyJsaj2ApLGEj5TUWJHrSXWAsFbQUhapd42P7ft49QZI/gyys/45FYl3z10zOZz
 Sk5xX1siRyayRsa3mnpkg5fd5GxuJ0QAZ1T2bF4kPmrKzdlbUV5hJZ8VOrOt4rIcjG4g=
X-Received: by 2002:a05:6870:51c6:b0:487:d8db:ebc3 with SMTP id
 586e51a60fabf-49089d600f1mr2848518fac.5.1790178411830; 
 Wed, 23 Sep 2026 08:46:51 -0700 (PDT)
X-Received: by 2002:a05:6870:51c6:b0:487:d8db:ebc3 with SMTP id
 586e51a60fabf-49089d600f1mr2848496fac.5.1790178411475; 
 Wed, 23 Sep 2026 08:46:51 -0700 (PDT)
Received: from noble-uboot.tail872496.ts.net
 (211-75-139-218.hinet-ip.hinet.net. [211.75.139.218])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4908e665df5sm2103963fac.10.2026.09.23.08.46.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 08:46:50 -0700 (PDT)
From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.u-boot-project.org
Cc: trini@konsulko.com, sjg@chromium.org, quentin.schulz@cherry.de,
 Aristo Chen <aristo.chen@canonical.com>,
 James Hilliard <james.hilliard1@gmail.com>,
 Daniel Golle <daniel@makrotopia.org>
Subject: [PATCH v1 1/3] tools: mkimage: use constants for FIT property names
Date: Wed, 23 Sep 2026 15:45:11 +0000
Message-ID: <20260923154610.339153-2-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260923154610.339153-1-aristo.chen@canonical.com>
References: <20260923154610.339153-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 23 Sep 2026 17:03:42 +0000
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

include/image.h defines constants for the FIT property names, but
mkimage still spells out two of them as string literals.

When the signing algorithm is given with -o, fit_image_write_sig()
records it in the "algo" property of the signature node using a
literal, while fit_image_hash_get_algo(), which mkimage and the
verification code use to read that property, uses FIT_ALGO_PROP. Use
the constant for the write as well.

fdt_property_file() takes the property name as an argument but ignores
it and always writes "data". Every caller passes FIT_DATA_PROP, so use
the argument.

No functional change.

Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
---
 tools/fit_image.c  | 2 +-
 tools/image-host.c | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/fit_image.c b/tools/fit_image.c
index f7d11904472..077906889ca 100644
--- a/tools/fit_image.c
+++ b/tools/fit_image.c
@@ -250,7 +250,7 @@ static int fdt_property_file(struct image_tool_params *params,
 		goto err;
 	}
 
-	ret = fdt_property_placeholder(fdt, "data", sbuf.st_size, &ptr);
+	ret = fdt_property_placeholder(fdt, name, sbuf.st_size, &ptr);
 	if (ret)
 		goto err;
 	ret = read(fd, ptr, sbuf.st_size);
diff --git a/tools/image-host.c b/tools/image-host.c
index 46036673050..3974ee3d389 100644
--- a/tools/image-host.c
+++ b/tools/image-host.c
@@ -167,7 +167,8 @@ static int fit_image_write_sig(void *fit, int noffset, uint8_t *value,
 		}
 	}
 	if (algo_name && !ret)
-		ret = fdt_setprop_string(fit, noffset, "algo", algo_name);
+		ret = fdt_setprop_string(fit, noffset, FIT_ALGO_PROP,
+					 algo_name);
 
 	return ret;
 }
-- 
2.43.0

