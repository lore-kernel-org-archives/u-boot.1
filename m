Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32025CA5FA1
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 22:36:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CECE680BB8;
	Mon, 28 Sep 2026 22:36:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QjOaD0N4de0s; Mon, 28 Sep 2026 22:36:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org D73B680BFB
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790634964;
	b=RK96D8seyq5Asd3BCHQr4FpbXq2u3J09KfuR41/dWhrflaqc/OB4gn0k56Ed7/wutSK+
	 y9hXZyPQhr7BzfaUbX6nstXPUslqvkVAP5kM+04Orgoz3PdocHx6jM5IX1KUQ9DZwdRDJ
	 Mj2Ouu0RWInauCQbtaHipNFcFTBhBYKXwr54zRVjkkq68EJLKjSBTVec12E6eq/3S+xMD
	 9ixigsWzVk+Z6u/7+3XJGU7AHB0IMFmeKEoF0M1ABAGYEvEyb+33BzGBQ3cxLL09Dh7Fv
	 dRs9EFSJCiaDFsvpDQVasI+Fp5Xl92hgFJEO7CAcr+gpiweD8DdZWfW7i6plak0rYZA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790634964;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=ICqQX5YTW4ha1wwViZ5ePdGh1z7UTbvtatxjUSVGf3A=;
	b=soLvT8spOVCB+Ifqa1mOplN5pI612nBZyRFSUzxX9z4d1Tpe7gVPQbEo6jgsJD8elunY
	 xr1cgbAew6iTtaUowHEbDPCTMkBr9JctgaIxFv+jKfU5Kvk96/caiTGAUsmkkZBbBF3Sa
	 ntHJb8IvjCCxiJW6XnsyXNB8HEkNUmQ+NBJ4V1IpT4mZZ9ilk6E2am2rTflwmIuZxTj+c
	 D7DGogl4sYFCTwQnFs+F6BSSUx9hrgJwtdBwIq15S1nwEif7d/xBDLzqvmqsxUPsc2tZc
	 L39KZJllYBZc56C7htMTmgfGIOd3gW7ZbW2QNymdJbWWX/tt9TE96mu967w1lQElEqQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790634964;
	bh=ICqQX5YTW4ha1wwViZ5ePdGh1z7UTbvtatxjUSVGf3A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=q1EzhjC2yKQxmv0522joE+ozeGUvgLOIDl4LI8oPuD17a50LXcYe/Li8ji5LMFVnq
	 kDuoLQFkU15o742lafihUNO1KosQuvwt9LKe3tJhXWCKbFwxSlMox/nUwo+hZ9lrZl
	 96CdS9R7fPbAsMtPGBpfu68xfgSgWZV5mm2qcT4lexE1/GB/85RIOBR/5RkEWRab8G
	 hFcVzNA11ayGB7tTWsPDYHfQAqaS4PZUekeO2lZyjkBoywXFg+4IAH5Zw0YJJM3dcL
	 b9eFxV/FB4+NU3FesskuzAbV6orbjB706nNr6dtyXzJK5h2aQXB9HudQM9oYgH/pB5
	 DAk0e4xyV9DjA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D73B680BFB;
	Mon, 28 Sep 2026 22:36:03 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id E795F417
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 22:35:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D9EFD40090
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 22:35:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Z3NndLOW_iPT for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 22:35:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 9E6ED4008A
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::134"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790634958;
 b=bWKVOxUor2gnrQY+jAPmrG8D0mLSRpXQO58UX3B9D9qlZiNKw0kgeGsfXw05Ceg4JIUG
 Xnf87DAwB2KeHVCLOfXFFo3reQqGy1jTOpW988Z09jbHtzpRzY5kvFTbfB9R7d1WeAFwI
 gYwn6A4Z+1m5od7xIbPehnwY9F1C6pYyR654dDJ9HkVdyEGt3gS3E/NfZD4l+1p0DWXpz
 Engaroy3BmAAKES4QCyDUoOA04MZ3QB54sKTYH+NEuy3VRexyXxXuI7evbO7thXrq1Fvb
 Jnw4LPMkVndkJ+g7HdwQnheL502jXo8CLOpmyKq9lJE0/tG+pd/aDOdgbHFitEds5xA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790634958;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=ICqQX5YTW4ha1wwViZ5ePdGh1z7UTbvtatxjUSVGf3A=;
 b=kZo1c85coVXoIxzkTHtZcZVfJz7NbG0x6/tXgvFQwSEz+x5goEW06yHCc3jk/LDjpw3T
 wBzCiOIuwP6dVEU4iaui2JVFvsivLB7GbnOMEI+Wh+x+jZSl7SLAKgqn7vK3dJJC8opf2
 GvXOj16xvfWLnwclKj1F/nRF8pQc0pD8RiYWezrnfI9siPh6FVv+xdOVNDabkXOE7jAfY
 HIgmaIVg2mBykNOyKyHHPtVnZtouh/R5lg9Q6okp1bHoNwdquhljF4TPulE629QHJIKWQ
 XOKTmA6LSRQfzVlAgtfQtb24t1j9AieQZyt3uKXHsPYb3SILfM+S4Tq3o77lLYrOenw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=KiO1XVqM; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::134"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::134; helo=mail-lf1-x134.google.com;
 envelope-from=sochnev.v.74@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=KiO1XVqM
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com
 [IPv6:2a00:1450:4864:20::134])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9E6ED4008A
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 22:35:57 +0000 (UTC)
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-5b8b3c8c4bbso252966e87.0
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 15:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790634955; x=1791239755;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ICqQX5YTW4ha1wwViZ5ePdGh1z7UTbvtatxjUSVGf3A=;
 b=KiO1XVqMxEW7Uo5lTeNMEFoDEb2pHraMk0HGx7qO8frkNYNB9ipoXihfijT5OnxyD9
 JMnrm/IyMr9/0fxaw87Jrs9nZZoE2StmLQ6+ITb3ZCcngYQkBv2HU/tnxqIq6PU24VRJ
 94+t9NuY5qceS+P9P21grfNXTEChOpEWhbvPqY9PaPxyRJ1PdHu88H2b4mieRb/Ah+GJ
 4rXK2TF8uHAzpfxwR6rPYi8KJd6f6M6WlwnRbmTP/cVYgVvyQSLHwr5N6U8BfGp9glNU
 drf5t9b56WKj4BhgdczZZsTWQrICKCvDmHxCG7l8/r6dOn69FBgxYECJBF4imUpjxhAP
 2zMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790634955; x=1791239755;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ICqQX5YTW4ha1wwViZ5ePdGh1z7UTbvtatxjUSVGf3A=;
 b=RkIs4fhZnOUKvvnrtOz0H+nxBKZl+C5xz8WYuaFjI/mLz/lIt79NA7kAruaak/gZYg
 bCbveFIhDgVRKazIL/FDcVsgHBs3MG1Oqr+F+h1GVT9UvCiR8me6jpTZi5gCa4JthrE0
 GTkrQ+vVOHcYVRiUhKBg6vB4bTAt5Pz+izbs/FTk9BR9ZCsizhK1VNGjHjpttc/8X5N5
 d9lBU1yhAuMWlAifZQCM58YMVbwhD5tPvRHexD3DFBnDtATd/LgSWg/mcqngZRYNc/y1
 DCyLv/6GwnJR+NBHBqeW08AXT15hf1PMTDy6SqELsRDzhxe1KqsgaubRvbHWdGmF8e1c
 jtXQ==
X-Gm-Message-State: AFq9FYL/BYKu7DdkEnC3Gx4R+htTMtgT9Ft0w6zvtzUB++wgnh3u6V27
 LhRe834O7EVPcFxVzvjJbPW3NWBWcqmuu+23Vk0kiBfNqqbYRaOwZoyYsFU3yq4=
X-Gm-Gg: AYBFou2OB88gOptqIRUkCN+4mu5QHXGHoEGxDybPG2lZp+BV3hvpdhBKQEvBnnmKUjU
 94iwxO5JpEuMFe4gEbdvdlF2r4AMTIomJE+fQmQzQ9rPaYVB3RRspGChpqbA/EpAdQzxmFOuKDY
 RQVC/gJO35hwhnM6L+c1Ijr+O8Iw4Lnw/jv8twwhsO/P9Xez5JKsOMAQFlqGTOHlYz9p5onCQxp
 nQxb01VzR6KfnUfj5XfQScMG3Y8i6Ium+b0EAUcyCvxn8S2InXYr0jn1NMg4gt9cshI5uCslH90
 zXOSsEBTehpTKFxGGRRIqjKXLxACV+jDVSpyxmus6+3hYexQ2nmcT9Vc+z3QZLEzC1COq6uMzOQ
 MvSzv2OxvOlWAYN5DlvP2jfZFCwfRh/DMG+hD0jvaUhkP2ua1p1tfj//1xb22UYFzKfq7h2qQ8E
 0Y1DatxGAT3X2rQb7uQAlUxGyJDTOJXf9ehvVBfTW/eJwNVQsGQKr5OAe/5rme
X-Received: by 2002:a05:6512:1306:b0:5b8:f56d:d13 with SMTP id
 2adb3069b0e04-5ba2e6a7646mr144483e87.40.1790634954956; 
 Mon, 28 Sep 2026 15:35:54 -0700 (PDT)
Received: from fedora ([46.8.219.5]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b9deba80c6sm863466e87.28.2026.09.28.15.35.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 15:35:53 -0700 (PDT)
From: Vitaliy Sochnev <sochnev.v.74@gmail.com>
To: u-boot@lists.u-boot-project.org,
 Jerome Forissier <jerome.forissier@arm.com>, Tom Rini <trini@konsulko.com>
Cc: Peter Robinson <pbrobinson@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 James Hilliard <james.hilliard1@gmail.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
Subject: [RFC PATCH 3/4] doc: usage: cmd: add httpd
Date: Tue, 29 Sep 2026 01:35:31 +0300
Message-ID: <20260928223532.482192-4-sochnev.v.74@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260928223532.482192-1-sochnev.v.74@gmail.com>
References: <20260928223532.482192-1-sochnev.v.74@gmail.com>
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

Document the httpd command, the environment variables it uses and sets,
and its security implications.

Signed-off-by: Vitaliy Sochnev <sochnev.v.74@gmail.com>
---
 doc/usage/cmd/httpd.rst | 92 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 92 insertions(+)
 create mode 100644 doc/usage/cmd/httpd.rst

diff --git a/doc/usage/cmd/httpd.rst b/doc/usage/cmd/httpd.rst
new file mode 100644
index 000000000..4b765c8fc
--- /dev/null
+++ b/doc/usage/cmd/httpd.rst
@@ -0,0 +1,92 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+.. index::
+   single: httpd (command)
+
+httpd command
+=============
+
+Synopsis
+--------
+
+::
+
+    httpd [loadAddress]
+
+Description
+-----------
+
+The httpd command acts as a minimal HTTP server and receives the first file
+uploaded to it into memory. It lets a host load an image with only a web
+browser, e.g. to recover a device.
+
+loadAddress
+    memory address where the received file is stored. If not provided, the
+    address is taken from the *loadaddr* environment variable or the default
+    image load address.
+
+Requesting ``/`` returns an upload page with one file selector per upload
+target. The targets are listed, separated by spaces, in the *httpd_targets*
+environment variable. If the variable is not set, a single target named
+*file* is offered. Target names may only contain lower case letters, digits,
+``_`` and ``-``; other names are ignored.
+
+A file is uploaded by sending it as the raw body of a request
+``POST /upload/<target>``. Multipart form data is refused, as it would be
+stored verbatim. Uploads which do not fit into free memory are refused before
+any data is written. The lwIP httpd reads at most nine digits of the
+Content-Length header, so files of 1 GB or more cannot be uploaded.
+
+After a successful upload, the *fileaddr* and *filesize* environment variables
+describe the received file and *httpd_target* holds the target name. The
+command then returns successfully. It does not boot or write the file itself;
+boot scripts decide what to do with each target. An interrupted upload is
+discarded and the command keeps listening.
+
+The command runs until a file has been received or Ctrl-C is pressed.
+
+Security
+--------
+
+The server has no authentication and no encryption. Anybody who can reach the
+board while the command is running can upload a file, and a boot script may
+act on it. Only run the command on a trusted network, typically on explicit
+user request such as a button pressed at power-on.
+
+Example
+-------
+
+In the example the board offers two targets. A FIT image uploaded as
+*initramfs* is booted, a file uploaded as *bl2* would be written to flash by
+a board specific script.
+
+::
+
+    => setenv ipaddr 192.168.1.1
+    => setenv netmask 255.255.255.0
+    => setenv httpd_targets "initramfs bl2"
+    => setenv httpd_do_initramfs 'bootm $fileaddr'
+    => httpd && run httpd_do_$httpd_target
+    Using ethernet@1fb50000 device
+    Listening for HTTP uploads on http://192.168.1.1/
+    Load address: 0x81800000
+
+    Receiving 'initramfs' (9437184 bytes)
+    Loading: ##################################################
+    Bytes transferred = 9437184 (900000 hex)
+    ## Loading kernel (any) from FIT Image at 81800000 ...
+
+Open http://192.168.1.1/ in a browser on a host with an address in the same
+subnet, or send the file from the command line:
+
+::
+
+    $ curl --data-binary @image.itb \
+           -H 'Content-Type: application/octet-stream' \
+           http://192.168.1.1/upload/initramfs
+
+Configuration
+-------------
+
+The command is only available if CONFIG_CMD_HTTPD=y. It requires the lwIP
+network stack (CONFIG_NET_LWIP=y) and uses the lwIP httpd application.
-- 
2.55.0

