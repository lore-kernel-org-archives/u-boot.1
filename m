Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61991606A328
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 15:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=g2+59pet;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EJKEu2oS
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3AF8A60856;
	Tue,  3 Nov 2026 15:33:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id K7mh_af8Gc67; Tue,  3 Nov 2026 15:33:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 2E64860850
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793720020;
	b=CUaUjKGig9RrQhL/SE5HDKNy63v0xGSQxbC/NKj5J/HM2fq5Sv7hder7tbnIoZ6lB4tt
	 qjncrCv5Abk3q/uEdScy4V8XY066n1KSM1n1kpC5ekO3mJ2IFWwKJ9Z11dFHh51Xn/umx
	 bZO+lUy7+dGh3p22AsZUNS/yOay3Q/pRwVgI1sO67usJzY+F6MbopIriObSlFmOZtivJW
	 GU7fHsGnpHmVC9YzDGL6ymnzw2KxWKL9bAKlfpZ6W5S5I7EiYTKyjNcL6jk3C3BU9CvYi
	 TTFBLaEGYHOfGhkH4rzeWfhczUGi+CyMcQvq6kHogHdUDDs/Wa+comDgZ6R7ITQPUuA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793720020;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=HyG2krtarKc8aiviw/LxL+3C9wv5ctCu2qRZiQtxKfg=;
	b=l0XodZFEH3VMWAx2q9UNQsqIKY0ICjn45hwUvW9ASV4BGe5E6K2CckgNHTBwGrTTNPZ7
	 EXLZE7PtFnigMO+Vht382nwUFhibreKIDQvgiRYBvZIYELIvtGxmT1a1GXDa+fiOt+hPH
	 k9z9yGjVtjF/cxi5ikA3x1hlpuoexqiHn838WAHxl7xk7IJVyYNZ9/+Jdu4coB1GXXCGg
	 n+jYenfggaY+I/z31PaspaEva+0OAS5neBxUe0mcEx/Lqbp5Bfdu7RRyvbjR7WvGmALRm
	 jeJzgxred6u0Ew6kPS7pd/1Ohq3jMM4cLk3k+jtMikLsWabtEN7glEiyPtp2RLwGs0Q==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793720020;
	bh=HyG2krtarKc8aiviw/LxL+3C9wv5ctCu2qRZiQtxKfg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=g2+59peteRCavQ0+SF9Y1r7gshelcM6ItGK8/kwPdz/ebIfmxV70OHiXNNES07opz
	 jyHeWba5OzS2Y8bCJ1cFIkLcGFFgcTpWwJ+CXUCd1SBCV2U1fc1vSt0ZkKL2UDDmJC
	 UXv+MD03Rysat+Zxeve2tMeKfhoo+9Zlyr+3zorytC8kpmgxWaoLwBV/vkOa+8MUP3
	 tQO5odtAac8pwu8Dw9T+TcvzReA5LKnyTPblev0QFz4V7586P032WRLFZx2mmhVc/u
	 f89y+c+ZbeU4+4ffbdeRNniA8lrSCb4aWIOIGoC7kKc84GvSW220s7OgxwCcHp0Yrr
	 QYS41fIL8awlg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2E64860850;
	Tue,  3 Nov 2026 15:33:40 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id D1C0A235
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 15:33:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C237840665
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 15:33:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id I1T9Iv2zPaCS for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 15:33:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 9C3B14064F
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32d"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793720018;
 b=MaP34PF9bCAignSyG3MtZVvtMMgQF5bzu9w1M2cmgGndYUVeYAkynuOZse9KXhBA1IPp
 C9c55V28Am6T3ETsA0DRSDs7dZx3kxKEPJB7W6ZmyGwPAnCDos3UvLgP4T+/2wBonC2/3
 EvY0UAfYU50SiBzhht90jvZU6YD9/pKkw5fumxXb0DPRk/sbiNWcUsahal6AvKKYpQtcX
 G976//NIZrbfuew106zk8H5FHonXOqdbH7NneRs/0RqmWRawqUGgTvksSgPx50jt1sCQM
 91lA8eTJ6QICfHFYU/kFe7ekYI/CJ4IgQskrPX9ESm9ydHw9yQsFh9bAIFiwMucWQ1A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793720018;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:In-Reply-To:References;
 bh=HyG2krtarKc8aiviw/LxL+3C9wv5ctCu2qRZiQtxKfg=;
 b=dwmt7czJbmt7ic3XukmZEOhngLBmOr2aI/QDFtp0i0V4th9rCefqlJrFeWzKEfkH5OhY
 psVL1xUs9K6wJ1xl3Zi/PikUslLzZkDGr81Y5ALdPwGa1OHpF0AsiUdU6SowT9KlF3GrL
 6qKFm5YPB7BVDp9aUOrjJggcJjz4AhYv0IBTJnbPDwxa95WKLeFYVqyItQ33D5ipk2Hyf
 rDUVqCjTHQ9Esn3bTzeZz5BebCJDVGyrfhXZm4gLoIWBLheCC/AtjZkGlW0BvAQadZaHo
 NU3FUP4n44MVttAiVqvhsDAPvXjalaIm1oid4hpGGCfSqkq6MWCH4W1tmIb183A0SBg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=EJKEu2oS; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32d; helo=mail-wm1-x32d.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=EJKEu2oS
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9C3B14064F
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 15:33:37 +0000 (UTC)
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4a20a37703bso34533675e9.1
 for <u-boot@lists.u-boot-project.org>; Tue, 03 Nov 2026 07:33:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793720015; x=1794324815;
 darn=lists.u-boot-project.org; 
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=HyG2krtarKc8aiviw/LxL+3C9wv5ctCu2qRZiQtxKfg=;
 b=EJKEu2oSKtWgB489sEQdNLurmbX4AVxzmw0+3Q1l7GaC5t9lkyffXU4/WYE0k8cTiR
 B7e+Sj1nCROBqNDZcytlC7NubWv3rC9rgvJ7Mk4RYtGK3uMuXMHepcpogR3jMkrZTl7c
 gsVXtGg68Ry2D1hntzAR80Cd7PEHwHLA2L4ZwrnZWZMk0W1UtCsPO6p20PE4e7AJTfAD
 GU2Z9j6johw7b5lWQvNYLrx78z7hUs/P6AR0QjNcIL6ZFt5B+fAYn2QylI4rC6Sah41z
 wVJY6b5nVniRYrPfkM/4sZerckszl+o3ncGMfD0jrHffjgW31SLhsvWqdvrCvKSCE7eb
 Airg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793720015; x=1794324815;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=HyG2krtarKc8aiviw/LxL+3C9wv5ctCu2qRZiQtxKfg=;
 b=OBSkN2Ir8LAdRrPA0xaTVTcvBC4izSH4/5mPHaeR6AOmT9lkA5nB1a/J8+V3h4ALQK
 9q1CUOQl/RRTgmAPoygZEmdFLYHXIXNLTyJewO3kEOwM1G6HahSWsZBYPe1vWd8Zg6RJ
 EKb4vx2cJHa48QEYpOSIDWgeX8bgPhoQaJvxOhIP64+m1wU+1pjOxJnNFzAu/o/SBK5Y
 gPZGiSzHnKLL5OfLHAhA+WQmsw/CcfAffYmssqGDfhGczgYL4uTQQn0p2gvNyYwiWAv0
 acrk5B5V7NhmIy/DxzmqC+xrrtTNfFVv/69KMX7W93opogwqjsesvxWF27Fopp698COu
 gQyQ==
X-Gm-Message-State: APuU4Z8E5T4QUtiG8oi3Fe2E/taEIgYAFvtH0Q9eyLCpfaJNhMiWmqeX
 8mJYy/gcyUTNpELYuFjJqhnnezBu2A/56UhH+7zeF4i3mbUBi2X7hJLN5eBidJzmy3rAa92F
X-Gm-Gg: AYBFou2mxjYQqlW7toP5HaNZh2R5EExHjiSoWoeldanf6ikDM/nSS4BHHQHWOyN6JYJ
 6pF0IP9rR/Kzu3fCXUDsy1FI4MJ/DXS9y3byqyF7oV23gnnrfug/C2hvIeRBKwRqr9/eZx5B0oZ
 Iei+F+REQDN/ID9+m4gwPCaB2z/vnojiAr12eSjBH6bwsubJ9iby2nEs+Cvq/I6tG5D4bDoI7Dq
 kDk3XaiFa01oiXIbpdREEtWVd8IPEsAmXQt9yVBaOxE3PJySQwedH1Roe72KKxftJyO2+x1rkhr
 luPSIPpJD1Y7uYk3xljJAohcI58Y3Oy/0NIGK1z9zpzD9FpzKWkRUgdko//R5oDz5hXgtuIi46i
 ugGQf3w9/VLtt0nCvrRVBU/d9YcYh73N9CXi/EfyPNBO4O3xb8GC46rcFMBactnc6Axzpb+3RYc
 JsEGZFa4+c5KiRrV8xDDimU/onuQG529NXop+p63OpuvC2S0oqZ4h+De5+IwlAuzKAQpZ8Lkh0x
 v4lVRkEpKaat2rnkSeQpxZIhe1eD2rApFmBPDC9xFr/+33R0kUE+jziZjcIpvPJXPiygA5lNXdM
 v/L+WHD6zCega3nVp59piTbkEEvjT4i1xfiReXbRzjSlriCU8p23
X-Received: by 2002:a05:600c:b8a:b0:4ab:c447:49df with SMTP id
 5b1f17b1804b1-4ac182dca8emr299144925e9.23.1793720014884; 
 Tue, 03 Nov 2026 07:33:34 -0800 (PST)
Received: from [127.0.0.1] ([85.204.204.133]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ac09ad35fdsm239885175e9.2.2026.11.03.07.33.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Nov 2026 07:33:34 -0800 (PST)
From: Ana Bobillo <anabobillo3@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH v2 1/4] boot: pxe: Refuse 'include' in a config file read by a
 bootmeth
Date: Tue, 03 Nov 2026 15:33:33 +0000
Message-ID: <f967a89e-7702-4f64-a83e-e863c9317662@gmail.com>
In-Reply-To: <68656bc0-c727-4d25-8066-f2633c04e02a@gmail.com>
References: <68656bc0-c727-4d25-8066-f2633c04e02a@gmail.com>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

From: Ana Bobillo <anabobillo3@gmail.com>

The pxe parser reads a file named by an 'include' or 'menu include'
directive to the memory just after the text of the file that includes
it, then parses it from there:

	err = handle_include(ctx, &p, base + ALIGN(strlen(b), 4), cfg,
			     nest_level + 1);

This suits the pxe and sysboot commands, which read the config file to
${pxefile_addr_r} in free RAM, but the extlinux and pxe bootmeths parse
the config file from a heap buffer allocated to fit it, so there is no
room after it. Since extlinux_getfile() accepts a file of up to 1GB, an
include writes the included file past the end of that buffer, over
whatever follows it in the heap. The included file comes from the boot
media (or a TFTP server), so its size is not under U-Boot's control.

Add a no_include flag to the PXE context and set it in these bootmeths,
so that an 'include' is refused rather than written past the buffer.
Includes could not work reliably there anyway; with LMB, the heap is also
reserved memory, which TFTP already refuses to write. The pxe and sysboot
commands are unchanged.

Add a test which boots an extlinux config containing an 'include'.

Fixes: 31aefaf89a5b ("bootstd: Add an implementation of distro boot")
Fixes: dab2c2859b68 ("bootstd: Add an implementation of distro PXE boot")
Signed-off-by: Ana Bobillo <anabobillo3@gmail.com>
---
Changes in v2:
- Document no_include in the form the other bools of struct pxe_context
  use (Tom)

 boot/bootmeth_extlinux.c |  3 +++
 boot/bootmeth_pxe.c      |  3 +++
 boot/pxe_utils.c         |  7 +++++++
 include/pxe_utils.h      |  3 +++
 test/boot/bootflow.c     | 44 ++++++++++++++++++++++++++++++++++++++++
 5 files changed, 60 insertions(+)

diff --git a/boot/bootmeth_extlinux.c b/boot/bootmeth_extlinux.c
index bce6b499571..16d6ca36791 100644
--- a/boot/bootmeth_extlinux.c
+++ b/boot/bootmeth_extlinux.c
@@ -173,6 +173,9 @@ static int extlinux_boot(struct udevice *dev, struct bootflow *bflow)
 	if (ret)
 		return log_msg_ret("ctx", -EINVAL);
 
+	/* The config file is in a buffer of its own size */
+	ctx.no_include = true;
+
 	ret = pxe_process(&ctx, addr, false);
 	if (ret)
 		return log_msg_ret("bread", -EINVAL);
diff --git a/boot/bootmeth_pxe.c b/boot/bootmeth_pxe.c
index 7e999730e6a..a368479da02 100644
--- a/boot/bootmeth_pxe.c
+++ b/boot/bootmeth_pxe.c
@@ -143,6 +143,9 @@ static int extlinux_pxe_boot(struct udevice *dev, struct bootflow *bflow)
 	if (ret)
 		return log_msg_ret("ctx", -EINVAL);
 
+	/* The config file is in a buffer of its own size */
+	ctx->no_include = true;
+
 	ret = pxe_process(ctx, addr, false);
 	if (ret)
 		return log_msg_ret("bread", -EINVAL);
diff --git a/boot/pxe_utils.c b/boot/pxe_utils.c
index 8ec48a43bfa..1b69088b63c 100644
--- a/boot/pxe_utils.c
+++ b/boot/pxe_utils.c
@@ -1142,6 +1142,13 @@ static int handle_include(struct pxe_context *ctx, char **c, unsigned long base,
 		return err;
 	}
 
+	/* The included file is read to @base, after the file including it */
+	if (ctx->no_include) {
+		printf("Include not supported: %s\n", include_path);
+		free(include_path);
+		return -EOPNOTSUPP;
+	}
+
 	err = get_pxe_file(ctx, include_path, base);
 	if (err < 0) {
 		printf("Couldn't retrieve %s\n", include_path);
diff --git a/include/pxe_utils.h b/include/pxe_utils.h
index 817305dfd28..15f0ebf6609 100644
--- a/include/pxe_utils.h
+++ b/include/pxe_utils.h
@@ -107,6 +107,8 @@ typedef int (*pxe_getfile_func)(struct pxe_context *ctx, const char *file_path,
  * @bootdir: Directory that files are loaded from ("" if no directory). This is
  *	allocated
  * @pxe_file_size: Size of the PXE file
+ * @no_include: TRUE : refuse 'include' and 'menu include', as the PXE file is
+ *	in a buffer with no room after it, FALSE : allow them
  * @use_ipv6: TRUE : use IPv6 addressing, FALSE : use IPv4 addressing
  * @use_fallback: TRUE : use "fallback" option as default, FALSE : use
  *	"default" option as default
@@ -129,6 +131,7 @@ struct pxe_context {
 	bool allow_abs_path;
 	char *bootdir;
 	ulong pxe_file_size;
+	bool no_include;
 	bool use_ipv6;
 	bool use_fallback;
 };
diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
index d478fd575be..f24d79a34d9 100644
--- a/test/boot/bootflow.c
+++ b/test/boot/bootflow.c
@@ -741,6 +741,50 @@ static int bootflow_cmd_boot(struct unit_test_state *uts)
 }
 BOOTSTD_TEST(bootflow_cmd_boot, UTF_DM | UTF_SCAN_FDT | UTF_CONSOLE);
 
+/* Check that an extlinux 'include' cannot write past the config buffer */
+static int bootflow_extlinux_include(struct unit_test_state *uts)
+{
+	static const char cfg[] = "include /extlinux/extlinux.conf\n";
+	const int size = sizeof(cfg) - 1, guard = 0x400;
+	struct bootstd_priv *std;
+	struct bootflow *bflow;
+	char *buf;
+	int i;
+
+	ut_assertok(run_command("bootdev select 1", 0));
+	ut_assertok(run_command("bootflow scan", 0));
+	ut_assertok(run_command("bootflow select 0", 0));
+	ut_assertok(bootstd_get_priv(&std));
+	bflow = std->cur_bootflow;
+	ut_assertnonnull(bflow);
+	ut_asserteq_str("extlinux", bflow->method->name);
+
+	/*
+	 * Put the config in a buffer of its own size, as the bootmeth does,
+	 * followed by a guard area which is large enough to hold the included
+	 * file and which must not change
+	 */
+	ut_assert(bflow->size < guard);
+	buf = malloc(size + 1 + guard);
+	ut_assertnonnull(buf);
+	memcpy(buf, cfg, size + 1);
+	memset(buf + size + 1, 0xaa, guard);
+	free(bflow->buf);
+	bflow->buf = buf;
+	bflow->size = size;
+	console_record_reset_enable();
+
+	ut_asserteq(-EINVAL, bootflow_boot(bflow));
+	ut_assert_nextline("Include not supported: /extlinux/extlinux.conf");
+	ut_assert_nextline("Error parsing config file");
+	ut_assert_console_end();
+	for (i = 0; i < guard; i++)
+		ut_asserteq(0xaa, (u8)buf[size + 1 + i]);
+
+	return 0;
+}
+BOOTSTD_TEST(bootflow_extlinux_include, UTF_DM | UTF_SCAN_FDT | UTF_CONSOLE);
+
 /**
  * prep_mmc_bootdev() - Set up an mmc bootdev so we can access other distros
  *
