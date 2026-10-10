Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FD74CA9EC0
	for <u-boot@archiver.kernel.org>; Sat, 10 Oct 2026 19:10:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 916DF60668;
	Sat, 10 Oct 2026 19:09:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id thdmzHHDf5S0; Sat, 10 Oct 2026 19:09:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D9158606E2
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791659398;
	b=L8WK6LQnytF/AKbI6+tbcOPTLcdzuelQcdm0z2uA81nth0sJsvgM4wHP/cOgSPeuomD/
	 2skudGiacY4YurxIpBz+SLHCIs34RDxI72j3RoNXAtmLAXktT9ubbEPOHJsrzBAvQKHRu
	 +iW5q/+mhypMG97xgsR6J1AW7XSzFjFOB8A1Sti69/hcXe/IfYKD5nAXmQcs5mvAy//tH
	 elPQZA+nriZgpf+Yw4tgsB8sJGNc9630hPv9gG92DHypoJw4gqost05Rv3ZXn2Hcu/EJP
	 s0LBZexHga0zkKNasZvCvnb/Y4ttLx9cRTQlq9bR+yH7b0jEuf2wF+XJwiBEMr0KThg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791659398;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=uPRvHt4vb21Y7tftjO58aBt1u5Ptmdq8zcy5syI6Aw0=;
	b=c0kesRDb1i8vLjDNFeNOdbzwavQNNgG52elU9uqXEYBuNviDCMqgcmHygdNo8zoHqxnF
	 G0N69AhJBOafUaxEUmaHFij1pop9cU2vfg9gd5Az5uJZ/T5l6jpLt4Jk3wFGIQXV26ami
	 JvnpRAF+Zh5cKMk7VK0jZ/nUodBKsYOa2Q9lnXhgXNZA5om1WvfKnzxgimRoOZDN/cF9z
	 H2sk1T2OSCDDDjSL4ZOHbzJmNfxnQajlN++lkyHPx30uU0vqllcgKi6KRCEr2GH2eR9Pq
	 3Hq8Du2w0tk/piIqaeOr9/BUGU68MiMTU+iGaXjQDFpDu0HeSVJAljoDyK28sNLht1A==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=upkAfL5z;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791659398;
	bh=uPRvHt4vb21Y7tftjO58aBt1u5Ptmdq8zcy5syI6Aw0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=nq7j2dEyNSbhjwbZH/CuVD2bTmZXx+GGltLeHh8/q/0dZi2dvAscV5FJnqo+A41Og
	 0VIDhmuO8DG6qwU6IwVsLufcb7+vMSz4iF2MVhVoIJsyl8Z/hZKz6uC7rtkecKSDiv
	 sw6NNtAjkURGiJPlpFmsNyhHZ6BDn9XKzEB7YTExFmLZ7kVNFutIr+crVvKpKvOqyg
	 cZXmXmTAN4DmVr2S1z13kHdiaJQN5/9gIU8QEgRTpWD8u0yFlfpnw8fcx0lmnrWH0S
	 1J6oniBPK9wNrX86bQv1Ha3zI12/ePkbiuI2sKvSavI0LSwRGgxVutcdzKG68hoj9w
	 TFfPMmL1VdDYA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D9158606E2;
	Sat, 10 Oct 2026 19:09:57 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 33AB51A6
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 14:24:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 254C66064B
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 14:24:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id s6ait8lVRuuB for <u-boot@lists.u-boot-project.org>;
 Sat, 10 Oct 2026 14:24:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 77BE160639
Authentication-Results: smtp3.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791642293;
 b=nE5Xvkg6ppHnDVnKh7p1/lK0Awn8UfcKrTctX4hRUDsLWRgIRpLq5wfgXczYNkzPFQpn
 SD3aYUvfxVi4Gn1ioW7zUdUYpltuqfmpY3qM4POkpdXlgFuxg2o/tkCAr3OUF8NQ5nf2f
 Ci8LF7/Uea6I8E3ZGW1XXcIm098xlikgmVC0FeONwrgIJeVVeR1IoGR/MDSsQftOCju3L
 Xu/5Vjmh1sdCvwr4t0nPgAW6HXINoISihlNZHboAiwqDCNwi65zfE4yYEKdvefWVr8Sqg
 TtCwPbGsWPNlTCRvK0V2WkCpVYlz8hd4agHbobIsHbQAga8wbhUuPD+bnUIZRV2oNYw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791642293;
 h=Received-SPF:Received:Received:DKIM-Signature:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To;
 bh=uPRvHt4vb21Y7tftjO58aBt1u5Ptmdq8zcy5syI6Aw0=;
 b=Ksf14Y9G7f0kqY//9JiNPC0OeVI3N4t/1T6btDJ9v2LaJbdnM2GOK8cXkLGRFx/42B9S
 QToqm7yWObMupq5zecfb96dXHho5xqY5GyhFqtFV7jQHu9GUtUe382bbJ1CWoK/X0S1pA
 1BQXk1C3DMbSuPpQnpaVRlnnXiQMOYyhoGx8sNmYX567PSBHM5bl8S9jBDPKw1CuWejnM
 +qLbWuM4yKBysSqijrreJco7IgCRVyssCfTGxVie1BUUTlKF2L1oiJbXmGITVWXRIE4XO
 P4omQP/o1pc7kJpkS/TtwsVm5gXz81h6I7sQGHoxOZ+LHGN6lijNklaKzWAmiq6cwYw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=upkAfL5z; 
 arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=devnull+petr.hodina.protonmail.com@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=upkAfL5z
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 77BE160639
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 14:24:52 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id B716B40559;
 Sat, 10 Oct 2026 14:24:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 96DE4C2BCF7;
 Sat, 10 Oct 2026 14:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1791642292;
 bh=PLlNnoc3/wpvowrvKtj1s42kXqpC3kNz7fcOiYjf1Mg=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=upkAfL5zqzmMP6YTsEvDZLNQY/m5StgG2hRsfWahKt4pQc2JUVnFJ74OgFJxrhqDN
 ZAoWcLE7D0Dyy5NdOa9iZgiwUnI8t53a9ovlbo+nZLSDennEgaQTeJpP0l0DvStTGx
 9PzPcAIM2iUTWpdNssPwaiBvLP1r5BriJq1mG854DPosYFRmxkZKM0OXbhmoud7Dee
 35QLdQKOtB7VPGJzhd6IZhnkMpzc6/zqztf1i0kPHsvVnbmP5R2vt/Z9mduD1RUjLr
 ngK6QOqn6s5mU1laAVdO+rXP0TiA7h+F9d2RvRjyrjdQzqea4lib5tHYFBjvNu+Ytd
 2apo5iqeXnCmg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 759B2CA6017;
 Sat, 10 Oct 2026 14:24:52 +0000 (UTC)
From: Petr Hodina via B4 Relay <devnull+petr.hodina.protonmail.com@kernel.org>
Date: Sat, 10 Oct 2026 16:24:45 +0200
Subject: [PATCH 1/4] binman: fit: Actually compress generated fdt images
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261010-b4-binman-fit-fdt-compression-v1-1-4465558758cc@protonmail.com>
References: <20261010-b4-binman-fit-fdt-compression-v1-0-4465558758cc@protonmail.com>
In-Reply-To: <20261010-b4-binman-fit-fdt-compression-v1-0-4465558758cc@protonmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Marek Vasut <marex@nabladev.com>, 
 Wojciech Dubowik <Wojciech.Dubowik@mt.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Petr Pavlata <petr@acrux.cz>, David Heidelberg <david@ixit.cz>, 
 Petr Hodina <petr.hodina@protonmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791642291; l=2294;
 i=petr.hodina@protonmail.com; s=20260107; h=from:subject:message-id;
 bh=WWCtcfzM04pZoSaC6AMeIgI+OBKsFFnA2qcX3NOlT48=;
 b=qlDB1U29okYilIdHcZjahhPdltZM9qJU+jzSvtd/kkkAQ2oSpin2MDmEZ4Jn5ZM1wPqoqQpcO
 046X/81w6bnCSgEj/mJgdeYGqXct6E2c3VPmfgM8N0ZqRZjBcA4J5TK
X-Developer-Key: i=petr.hodina@protonmail.com; a=ed25519;
 pk=3QaVc6AaAu1IsyyH86+LIOOFhD7kCws8Xhe+wwyE7Bg=
X-Endpoint-Received: by B4 Relay for petr.hodina@protonmail.com/20260107
 with auth_id=594
X-Original-From: Petr Hodina <petr.hodina@protonmail.com>
X-Mailman-Approved-At: Sat, 10 Oct 2026 19:09:53 +0000
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
Reply-To: petr.hodina@protonmail.com
Errors-To: u-boot-bounces@lists.u-boot-project.org

From: Petr Hodina <petr.hodina@protonmail.com>

Reads the node's "compression" property while generating each fdt
node and actually compresses the data before writing it when the value
isn't "none". Only "lzma" is implemented for now.

Signed-off-by: Petr Hodina <petr.hodina@protonmail.com>
---
 tools/binman/etype/fit.py | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tools/binman/etype/fit.py b/tools/binman/etype/fit.py
index f28b1e6b4cb..026a373ff79 100644
--- a/tools/binman/etype/fit.py
+++ b/tools/binman/etype/fit.py
@@ -13,6 +13,7 @@ import os
 
 from binman.entry import Entry, EntryArg
 from binman.etype.section import Entry_section
+from binman import bintool
 from binman import elf
 from dtoc import fdt_util
 from dtoc.fdt import Fdt
@@ -853,8 +854,11 @@ class Entry_fit(Entry_section):
                     else:
                         fname = tools.get_input_filename(fdt_fname + '.dtb')
                     fdt_phase = None
+                    compression = 'none'
                     with fsw.add_node(node_name):
                         for pname, prop in node.props.items():
+                            if pname == 'compression':
+                                compression = fdt_util.GetString(node, pname)
                             if pname == 'fit,firmware':
                                 if firmware:
                                     fsw.property_string('firmware', firmware)
@@ -892,6 +896,14 @@ class Entry_fit(Entry_section):
                                 data = tools.read_file(phase_fname)
                             else:
                                 data = tools.read_file(fname)
+                            if compression != 'none':
+                                if compression != 'lzma':
+                                    self.Raise(
+                                        "Unsupported fdt compression "
+                                        f"'{compression}' (only 'lzma' is "
+                                        "implemented)")
+                                comp = bintool.Bintool.create('lzma_alone')
+                                data = comp.compress(data)
                             fsw.property('data', data)
 
                         for subnode in node.subnodes:

-- 
2.55.0


