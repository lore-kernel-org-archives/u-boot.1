Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FF28C61DBD
	for <u-boot@archiver.kernel.org>; Wed, 26 Aug 2026 16:34:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CD98240697;
	Wed, 26 Aug 2026 16:34:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id z6MgECG7X-YP; Wed, 26 Aug 2026 16:34:38 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787762078;
	bh=RELmIoRXiofGwgLqK12bAE1+0Vs5aNisdb3ZFAjkcq4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hxZMb40IkEAhsV+p7jPiw6OuWlFJDAofYTZrHQ2J5rYj4TIUUJ0LFffF6wbV2Kqdg
	 T0FOkah2c+Vg7XI94UHYWi3EKFLBENv8hHktno+guhWYc5czAPi7V59Bmu0LHDgpdY
	 64hX5FuRxkh5NEzknDeprvBHNC6g65fi8q4HDKpcNN57mYUF8zL61/55lbh2vi+/po
	 QenzCUn5JOge0bosjyd8ii2JwlIsf/Fp+0Cq/DWd7nOcKJtyYu0hIx/G/4qe4YIuwg
	 7mzr08mTD+i1VbwkUFMYbnZMHKSZZDnHWofemU57giDV9/wb54vpOp1ovm1WR1XNNT
	 VVpwp1DVvMmYw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A64B54065D;
	Wed, 26 Aug 2026 16:34:38 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 1262929B
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 16:34:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0481E80B49
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 16:34:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Z3zd3eEGEx2J for <u-boot@lists.u-boot-project.org>;
 Wed, 26 Aug 2026 16:34:36 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::636; helo=mail-ej1-x636.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net
 header.a=rsa-sha256 header.s=google header.b=CQ9vdLXX
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B808580B3D
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 16:34:35 +0000 (UTC)
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-c1600d040e4so11853866b.1
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 09:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1787762073; x=1788366873;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RELmIoRXiofGwgLqK12bAE1+0Vs5aNisdb3ZFAjkcq4=;
 b=CQ9vdLXXI/k/2O1J6fJYIbTL9enrVoigJC5AUEzx/EeoMP89ky3+SHYKshBoIwWvEb
 UQ1fxsSquymGTLz9grBjWe6mgjQ8Pyf4pclZ1OXspozq2GG9MCSgWTBf9K+vZHobatlW
 yuJ+DWusAQgzM1C7Ey3p5rNzNAt+oterm+QuJix8Q6R+DPe2TrAFEQiA/YujJIbw7sph
 ySKzvX6e6kiv0/xm/yNNDJc22cMZokUFb3jDYIpokJ63sXYXiHw4PkucFOURuVYz2BtC
 uPQD6gxF5U2U8pSGeWydk1+rkRdazUGuaO6OC5oCz0iVkjrBwmtP13VrPUIbPdQ4I/Gi
 M1Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787762073; x=1788366873;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=RELmIoRXiofGwgLqK12bAE1+0Vs5aNisdb3ZFAjkcq4=;
 b=bIYGLhk8Gu+yHSjiLTreftld8BqcXFhsSsbl6m/L2bNG55TThEpuvBxCW/UAqjLt4G
 IQG7/MnzTd6cWZNfK+eulTXiS2qt0ceja9RHKskPIdrJ6leF79miuiRvA+0aOL0gryuQ
 UAvMIKCX3G+4wFqgCFl/qOTrEidb6rwl19Z6+ZpM04K7txBPuNEdmn848rFyI4elMGmr
 qZYDFcRYAf5H+8CXmDs4zqTvLqNtcPMuHt2O5uilRbtUz+JD3jgiuG+QMMwz2jtIuqxe
 HaB/FgAeCBp4h86RR1SpQ5ksNG1qONP3SG0ldDQrDnVEtn09xvnFarBvwY26fXmSPGMG
 c6dw==
X-Gm-Message-State: AFuF++mNiOZFEkSu/uTs2Z/9SAypnnbzH9NTWPPgixIfAPeiGbayAKGA
 9CBAdjRygKHDhgwRhLyvhmiPSkwHx/HdAlE0LF1Ba+KMeCMc3sNp7gzdEXIwZHxuV7M=
X-Gm-Gg: AR+sD13VdxBecQaSXs+lACrBKsTxG+7XAg5miGqa/W1dr0q/ihj4gF098dtccxf0vws
 O1NCt5OoD4SIPXdKTKdlP+CCB2rf5s7UVAkl7wEPFDWwrsGb0Kwoop6tlDH5GzmyUWp2oFeQYlF
 I9h10oKo+GU7tTTljyHwzLqArqP2N/9FCP2kL6AgbIIWdT+8tI9Vh9TxdcAXSJ70WLzhyGgcdRp
 uJlXvtKPI0uEk0I1YBGFfMugWOBzWFatOkwtm2b849dXi1E7Txz9iv5QsQyA+a5279UXvCt0Ntn
 ACiwfLr8aQZRF8QDQgR1v0ExWm3uiHMO5HgrgvkLf0TM8rEEC0JOp40MVOKlYufjSdXGU55FRIZ
 Q44C7jfWDVDRNkMIlvgSjSmEEn7W4+uLWrqh4/iCnlk8RqlRUBfyoLngvRRwt4GyLR+iVLGtz03
 edJhoFA4nW7UmMaf+OqwiyNjs2ulfE/YWiXnDtJfODWKOQMAWdwWXaKKRUELJhtQuWWZdGrkpdN
 hyJuXyP7R3MJh43qPHXlUZcchpRpyZ0bL4vFrwg3F0k+UIDp5EBKA==
X-Received: by 2002:a17:907:9815:b0:c16:785:cfb6 with SMTP id
 a640c23a62f3a-c2535e368c7mr49801666b.3.1787762073298; 
 Wed, 26 Aug 2026 09:34:33 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-86-98-192-94.alshamil.net.ae.
 [86.98.192.94]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c250a704e55sm544907666b.21.2026.08.26.09.34.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 09:34:33 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Wed, 26 Aug 2026 20:33:55 +0400
Subject: [PATCH v2 03/13] pxe_utils: harden the "append" parser against
 malformed input
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260826-bls-v2-3-17df3c9548ba@flipper.net>
References: <20260826-bls-v2-0-17df3c9548ba@flipper.net>
In-Reply-To: <20260826-bls-v2-0-17df3c9548ba@flipper.net>
To: u-boot@lists.u-boot-project.org
Cc: Alexey Charkov <alchark@flipper.net>, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Daniel Golle <daniel@makrotopia.org>, 
 Johan Jonker <jbx6244@gmail.com>, "Lucien.Jheng" <lucienzx159@gmail.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Michal Simek <michal.simek@amd.com>, Peng Fan <peng.fan@nxp.com>, 
 Vincent Jardin <vjardin@free.fr>, Denis Mukhin <dmukhin@ford.com>, 
 Aristo Chen <aristo.chen@canonical.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1507; i=alchark@flipper.net;
 h=from:subject:message-id; bh=skexDohNoecZNxKxNtjsn7pz4VdMxzRVUB2IhvPRHXo=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWT1i/b+dg1/eC9g4ckPc2YZs72ZMmPnLMb2qKbgfX9jY
 oI407kiOyayMIhxMViKKbLM/bbEdqoR36xdHh5fYeawMoEMkRZpYAACFga+3MS8UiMdIz1TbUM9
 QyMdYx0jBi5OAZjqVW8Y/tnH1HL+jVjSKqRzQ6slaErnhFnzEhr8ThZbtbWzbjPcacDwV5BjTcy
 z7Hw1sYaZ7471XX0+46SN4evk+EMyhyqW9dYH8AMA
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
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

The parser can crash upon weird input to the "append" option:
- a bare "append" with no value makes parse_sliteral() fail on the T_EOL
  token and leave label->append untouched, so the NULL is handed straight
  to strstr();

- "initrd=" as the last token on the line makes strchr(s, ' ') return
  NULL, so the length becomes a huge negative number and the following
  malloc()/strncpy() pair runs wild.

Bail out on a failed parse, and use strcspn() so an unterminated value
simply runs to the end of the string. strndup() then folds the
allocate-copy-terminate sequence into one call.

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 boot/pxe_utils.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/boot/pxe_utils.c b/boot/pxe_utils.c
index 02bd43ac46e2..078eb2d0c244 100644
--- a/boot/pxe_utils.c
+++ b/boot/pxe_utils.c
@@ -1333,16 +1333,16 @@ static int parse_label(char **c, struct pxe_menu *cfg)
 
 		case T_APPEND:
 			err = parse_sliteral(c, &label->append);
-			if (label->initrd)
+			if (err < 0 || label->initrd)
 				break;
 			s = strstr(label->append, "initrd=");
 			if (!s)
 				break;
-			s += 7;
-			len = (int)(strchr(s, ' ') - s);
-			label->initrd = malloc(len + 1);
-			strncpy(label->initrd, s, len);
-			label->initrd[len] = '\0';
+			s += strlen("initrd=");
+			len = strcspn(s, " ");
+			label->initrd = strndup(s, len);
+			if (!label->initrd)
+				err = -ENOMEM;
 
 			break;
 

-- 
2.54.0

