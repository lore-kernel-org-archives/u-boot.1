Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA451606A329
	for <u-boot@archiver.kernel.org>; Mon,  2 Nov 2026 07:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=GVHR3Yys;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oJa6tL+M
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 98884809BE;
	Mon,  2 Nov 2026 07:03:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EqdOklPE2juN; Mon,  2 Nov 2026 07:03:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A719580E1D
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793603035;
	b=LckqYu0ZChnoRlsTJx0S/zHZ5N+5MIPftPUlfEIXR918pcWhSNkN5ojZjrdDunFro5ST
	 89TG+5CSjcaBwRKEEiqg8Dhrl10z0d1/v71cTLMClmC6Fq87P6+JylE6dXyahhzTRQQew
	 J/HYq9W0XsHiPyGWPwg9OU8ArtjmdvPmao8TVo/pH2i5H7mjXfzBgcwzMWShAevoW3W1j
	 9e7pzZXXHc0bSgIn2dnxVPbBDgUrWAXng/e5DmyhGJSJ7zBCnQoFWKZBZgd/sb1hlzZ01
	 0umJQdh80pwfsxQBPHAy6DcQ8f+P1wgJceOrEfDlwxKW2Jw2A8cEk4iEXoiRuEYSmdQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793603035;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=Nryrfu6W+A4dD3PiXfTr7geONO1PSFVGVe9CypWwdzA=;
	b=eplGHvARmq67FPN3yMTcjiNWyIsCDndigi75wWA7U5KnF4Hjq7Qd/YS39ELH4xJi4Iof
	 NtcgE2RZw3Va48iViMfUwUbNFhPQh8rDWKI/F6Gx0LOVzgNUWYOBG7xhLw5fkIbdlKRMu
	 jB+yrQPwtwWOLL/+76QOL5BIA05XnlbozHD47u2XjYiylNghAEBpNWOH17yIOwPHnPEoa
	 vKVjoNrgURavE7EvUPbYRW/61hpnUczy+9FrYXCPRD2fiqJysWTqL1ZiDqgrLV1VoOFK2
	 siDJk44wrDEbIhoy+kBIWyCnyhRmcuU9mLwzvFTAeU9Zv31zI/e0gUEEYyVjL8s2dOw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oJa6tL+M;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793603035;
	bh=Nryrfu6W+A4dD3PiXfTr7geONO1PSFVGVe9CypWwdzA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GVHR3YysJVrFZYfjup6RNOUa+QOcXqBRHhCth7+OgI5KBSiHeoyrKjJe2cN73dFsv
	 8aOTmQe+lnbpkPuOi9FFewg6gUQWN+55XWWUIcU9+qxhfyoxlMVK6VcDQ9KsS06D2Z
	 9e6ln9dBUjjPthvM5i3oDzmG4wWqoW4HingTjQRTwmNNjLKU4d9eiU0cQRuSNlCQ3o
	 HQCXd1yPVV5qNhnOVwCZSLSOw5XrzES/Ask6ZB7w8mTbTauoqs10cbnSRu9izo9pkk
	 tck9dc4sxk0vMMpTB0AMgFPEk/SL5OM8oQe5UV6sV8MG7dAxPx2ALcva5133cqyA3l
	 s0v5EtC3bz/0Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A719580E1D;
	Mon,  2 Nov 2026 07:03:55 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 7ACEF4BC
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 07:03:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5B529809BE
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 07:03:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZlPh6orZJb3q for <u-boot@lists.u-boot-project.org>;
 Mon,  2 Nov 2026 07:03:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4171F80E1D
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::335"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793603033;
 b=gAtRMYqC8+22sod/MwuSRpoKL2f3Hd8PABXv4yHAVASOpk2cZq7+bqwS6oDvMXXypzJF
 sDgFG5PTgCHW3+2CdL/FGNWjhlag1jYNr2LFXUjRS8xA5d5VNLy+K1kVf6L4dOH9xnNXl
 J+j9Go8OvsYCDOFvRrxsG9mKpGeBNORwRMq5KpwNK0QMygI4hsZI5eNdwDKC41xCsem6V
 IkiL+A0hg83Ja8q5Oa/YdLvz8siKovID17z7cVD/ZS+98/lId9lZqs1mnGEO+ipBTbaD6
 MaEG32yM8cSFfbuWANrNdwJE2HR6V4//yeB6zsOR6TRPy5RBGvCkLr6gltAs0/joynA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793603033;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:In-Reply-To:References;
 bh=Nryrfu6W+A4dD3PiXfTr7geONO1PSFVGVe9CypWwdzA=;
 b=YYt+qJ7jRNfPK0qBPBH+ZU/PbRqEdF9roOlEHD9KMhsQsrm+JAUtnAsfbQGPJd45fkOj
 8tGQ5R5VNlJKQ8Hd3csAQHiBLJBGN/eFdoyQf8DjnOO5OpIcZ7qY92Bm56uvKgY4SFTNd
 Z8hof3KGWltZRHRhgWXyDCEO8rEQwInhXLZch9tAbr7fq2PMfW9bd50XNRAPxVjR0ulKj
 +eLX3juGyMDUO3N+iHE+EoUtmTOEO3YR677wAXXxoQkXt7I21NTz6rHwmwGUcPnxsIEuK
 VXKuIGlu6kLnBiY2sjjk/dRAjOi3ObM5rcKleja+aIUrL141vOeYpKwlSAZNjvSrTTw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=oJa6tL+M; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::335"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::335; helo=mail-wm1-x335.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=oJa6tL+M
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4171F80E1D
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 07:03:52 +0000 (UTC)
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4ac95761c85so15444885e9.2
 for <u-boot@lists.u-boot-project.org>; Sun, 01 Nov 2026 23:03:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793603030; x=1794207830;
 darn=lists.u-boot-project.org; 
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Nryrfu6W+A4dD3PiXfTr7geONO1PSFVGVe9CypWwdzA=;
 b=oJa6tL+MakU+wqpfQvLGvWrckBjEGQ7zjz57/JbOegx6lsvKRFRju0z4xsEUxtUyi2
 x6Fub6T5Kq2V1ZDFBp7YlyEQokrnGXbBUUEr6U1vOTsRnQzY0e8yXrnfoi1zhazLU1pH
 GX+aiQlws6XAKIiGz23QoP8SyC/AkRyXnKgNTNtMKfL6HLHiw94dT4YgcIayglB/O60J
 PzZT1SavP6sabn3s8I4qHlTDepp/0FnYpEIV64qjPMo83VCyV05/q0ioeBAuxFgl0jvk
 J/s9ex2Ik/heWFvR3NKVhFsVFL51hJa/wTM7/Son09z1ij+sFGRjCewc/dE0EaY7V2yz
 CMjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793603030; x=1794207830;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Nryrfu6W+A4dD3PiXfTr7geONO1PSFVGVe9CypWwdzA=;
 b=wnmmtKdV8DXUQXVtELpZtkg8f0JSo5DLci7VPqDePoSALLBPh9sI+Bds8JimlUp980
 7OpEJWkrlwvPm2NA/LDG09DH5gc5Ugx3vZmZkwqPtzJQDKwK6P2QKm8wxDUVTNEGw0lg
 RuUjgZXRDBlKMp9iPSicAWBSaFDwqoSdz8AO6CCH1L+vzP62NFN1wENxj9hpMHuusmYw
 K7yqPVwzpG2qVVdv/H+LZxVF8sBidkNrf7bzo0Airey1giNVNVNEnH6ZP6/JgB9UzwV4
 OgFL24mVj4DbceOJrRGOFqDyx2XLPg1XbqgqAV+c45fO7y3Ly2mjyvb21IDNGgGDfkZR
 sewQ==
X-Gm-Message-State: AFq9FYKrvv8dGV9VLTtUVtkX3DuWsxI8a1P44Z7ldQJknnu52VpLXvIm
 N7dmdwUdFHOtXzUGDjHhAF2MNbwYl9A93/7CSP7hWRSr5QtV386GDsK0Qe1Ox3PKWLY=
X-Gm-Gg: AYBFou0PJ2y/YHmSe9goxSzlzwcePVcIqmvwUKPI/DOtRsyWDHdzKNygaYIqk+H/cxa
 7abY9yXdbUS8JtfNmeVGkte0WAfmyS10RuuZVuTSXB3El7824yTXfnQm7AS18FEZ8Bd7y1uBZa7
 4Ur/UeB1MzecdwTKK8b4WBeQ5vHEfX1C1i1LToKmdzoMuMcUZNx6fHBDDUeqCsa2EVfXrF2Lsw1
 9yl8m0LNDOMKzAQYBywod3JgTtoXQ0qY/dt7XE5cuDk8BsFvCHC8+Mv+7fmzMLl7Hprvx+ZM5Qu
 8VI26v9DN2QyBhtjehxHiVGbSQE3cLalIViu9NpIX/DdlBpqT51iIFoHw7WCHN1xK5zcILbFQys
 JkepUQs8mavkotMEzJjFVWkkLtNhV6aZ/x3aNDHNRq0KKkfPmPbYSqEfMD6lBR8ZT7ZJll7dNCZ
 DNh7/XS3k7tvqSZd5sGtXEzU3hlQIeIQtZHCdF1Ygb1E6/vmsKS1EToYrgHuFpVp2Rll63xmaTC
 3LxrxpNDisJ4Yx8t51zNvFIMdOHls1dG0TZhpCS+27DnKqcrpIZTAnwGr4zpBjvyIkfAeMr7NQi
 TCUciYoo2TeHyTLyhD6IdrBSXapK3Og=
X-Received: by 2002:a05:600c:6087:b0:49f:f099:6fb1 with SMTP id
 5b1f17b1804b1-4ac17753befmr207656505e9.15.1793603030252; 
 Sun, 01 Nov 2026 23:03:50 -0800 (PST)
Received: from [127.0.0.1] ([85.204.204.133]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ac09fadb75sm166430515e9.3.2026.11.01.23.03.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 01 Nov 2026 23:03:49 -0800 (PST)
From: Ana Bobillo <anabobillo3@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH 1/4] boot: pxe: Refuse 'include' in a config file read by a
 bootmeth
Date: Mon, 02 Nov 2026 07:03:48 +0000
Message-ID: <d405c1cb-83e6-410b-82c7-b6696ac25348@gmail.com>
In-Reply-To: <a601d668-436a-4aa7-bb10-950a89d324ed@gmail.com>
References: <a601d668-436a-4aa7-bb10-950a89d324ed@gmail.com>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
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
index 817305dfd28..95b306c5f10 100644
--- a/include/pxe_utils.h
+++ b/include/pxe_utils.h
@@ -107,6 +107,8 @@ typedef int (*pxe_getfile_func)(struct pxe_context *ctx, const char *file_path,
  * @bootdir: Directory that files are loaded from ("" if no directory). This is
  *	allocated
  * @pxe_file_size: Size of the PXE file
+ * @no_include: true to refuse 'include' and 'menu include', since the PXE
+ *	file is in a buffer with no room after it for an included file
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
