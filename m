Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D24CC43458
	for <u-boot@archiver.kernel.org>; Mon, 13 Jul 2026 15:57:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 969E684C54;
	Mon, 13 Jul 2026 17:57:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="RsuNVKys";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C39F84C13; Mon, 13 Jul 2026 17:57:06 +0200 (CEST)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 53E9284BE8
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 17:57:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-476a130c138so16524f8f.0
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 08:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783958223; x=1784563023; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hnu0CsfTV4gUhJloN1LELDK7hlONIcaE/qiCosiBM2U=;
 b=RsuNVKys7BfzwrGg3ketAHQkAzAqrKcBTEb3L1FjYQR9HNrB+bryC+2u2qvsBDxoyB
 255TDPYCbgwVt035FXZw3BeFqm/VNWoM+nUuknBI4nge3J7rLHiNAoF11qTA53tuaE69
 Y8eP1bVMPqmF4r/mLDkFzqzb59UwPg/UXnZM8bXfL0go/PLthdqgp+Gxc2z+vMLadLFJ
 gmIzD8/yGHA/1uftDeBWbe486OhNws+cblO8AUIBywrzj/ABGe0v+Yv00e1kDm0xT0Yu
 fSOZNEwReTRPI3E+ESsH3+T64ng39SJq20WUMCksighwiGXYtnIe8ipilFQ92Is6ytZS
 G5Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783958223; x=1784563023;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hnu0CsfTV4gUhJloN1LELDK7hlONIcaE/qiCosiBM2U=;
 b=LDkWM2ihwGI7+jkbQvmWeY/6LGWAgNkOOByRF3UyXFeMu1MNzoouL8KWiQNmwqKYgI
 ORwSoJbQREhzqG/otSQXw6c6Lw9BZt0akT8nAzfOK2I1gZgfU9lmmRmoYIOh/Px/27ym
 X2xncKQKbKf7sn4xLmm5BJmed9jSKngryB+uPix+nixcMutB4iaAUHGC0NsbO9PYrEx3
 pOzM+tGz2X+xX13BXFdr8aI3oTqUyc8SJC5Tc1RZhywDFypZjPHlKNgj+Ltpsun9Ctyf
 zNNo7GuRpj/Zi0RRc02xyYp/q98dewUnVbLtDbhRJyd8I3YsgJ0xMJwOlUlJ9oVOpBFq
 2GRw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrQn1APXkRZjl/agUTv5caXh0CLv/iU2hBGSVL8JZ09OhW9lxkcr57cRUpOH5PLO8NexbLNj4I=@lists.denx.de
X-Gm-Message-State: AOJu0YwYrWWRILI4RFS90sxRyOY4ySM7aqU0nkSc+UIEyqIFWpG08hYp
 Kh/zjKDraIykADZHdaj9REJOv1yK593pwxdBY/hUmExkfp3DiZf7ODcLzU9Zdft4lnU=
X-Gm-Gg: AfdE7cnVwpX9JoWs/DAKwyL7o+wXACx0wA456O7p/mjYhZO3X0UX0wJQ9IAtCNQPonP
 KJ88xblAjZu2d9QZdLdZdMt4bd8QfAlncaqoPpGrMIsBkld9sM0jDVRxp9YXLYUqG/2l3Ge/wJr
 +RpteOup3h0KviAfUsj0NbWHwCSnuNVx/S7rmFh3n5a5ddQGMUULPGgSgFtUaRWzkttZK6RQHis
 pyc4x5quSs2kC+MwfE0RL52h2mXjwKDWs9LWofYBc7wQvxgsv0YGYmouArNxuu5B0h8YGFvw+ts
 /89h4ZeaQY0odXYD2izmrQBSEsd8cimUDG6yxM0Y0OxyBhOU8XPqhVyBhUlyEsFnrpMXexlNpgx
 0E7O/bsqbMeF/YZy+qJ1WFoI1oJWt5Vsp5PuwnEPdDNm90r2ugrG+p3Kj85t+0oCjNiVoWjel4o
 sQWuu9/Qqhmjk0ScQoOsua6T0oi6iNb3SiXMvyHhvBeNiP
X-Received: by 2002:a05:6000:612:b0:475:613c:c9f2 with SMTP id
 ffacd0b85a97d-47f2dcd1b38mr11649766f8f.5.1783958222604; 
 Mon, 13 Jul 2026 08:57:02 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f4634debesm352946f8f.8.2026.07.13.08.57.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 08:57:02 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Mon, 13 Jul 2026 17:56:57 +0200
Subject: [PATCH RFC v3 3/3] MAINTAINERS/README: Migrate mailing-list to
 lists.u-boot-project.org
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260713-osuosl-ml-switch-v3-3-48b71dec1a23@linaro.org>
References: <20260713-osuosl-ml-switch-v3-0-48b71dec1a23@linaro.org>
In-Reply-To: <20260713-osuosl-ml-switch-v3-0-48b71dec1a23@linaro.org>
To: u-boot@lists.u-boot-project.org, u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Peter Robinson <pbrobinson@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tony Dinh <mibodhi@gmail.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Heiko Schocher <hs@nabladev.com>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Quentin Schulz <u-boot@0leil.net>, Heiko Stuebner <heiko@sntech.de>, 
 David Lechner <dlechner@baylibre.com>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Daniel Golle <daniel@makrotopia.org>, 
 Philip Molloy <philip.molloy@analog.com>, 
 Walter Schweizer <walter.schweizer@siemens.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2258;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=wj184bPQ3SfpdeOnv2FVm7oAY+zHzVUHSrFsufy8YZU=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBqVQrIn7MEoID99bJq+HBQFqK3NkNfm/6Q7BvUHUl1
 4Q3gtyGJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCalUKyAAKCRB33NvayMhJ0TmyEA
 CFWR7W1U0vctmOqd6Y3MKKxi9S+4z9d04cG2n0RDolI9pLX781qdA2CMbZPU86grD7iav6EiFwP/HY
 w5xds2OCulJ8op0pi/TRRug7T70BhpiQWwEdy0f/IDHRHu9rs7q4+CCB2z7zVXo0wNC+t1Y+K9zXll
 m+I2i6iScrlMwpFrxpFApsoFsQnfDrHfNjxIko4fqSIquMAC24PuevpmtZg3iSoUsmagmdmV4n6MR0
 ByiixD6jCTCiBJCNDzNkxfwbXLbCnMY/ZFLZlTYdXCKGekjmZopobpgcFDSNP3hsILAsL9RjSNauxc
 RtU/wDlpDH/6TZujqLguvUarr7I9eBg4V68FZIIHGMIBdCfPsk5wDFJ9tWGRG2MyqdNk9j19zyhbiK
 57QfOeR8JARb8v+EE6GSExbQXAGQafws8tMBq4nO9D5u4/0OD1cYO+kkaX+esj93hMBPTYHRXO/Nnr
 UfhCkctF3MewkzF8cuRDe/JHL6kUXiyecMOPmiodS4K7ZamGlGdYh3oinVUGKRu+b/73I2LCTDxk7o
 VMM3MDQUeYKiVEDPSirCNft4EJHzQP5mOiSUHHC6PNQay2E+Q3bK+D/d5DEDEZyIOkyZgNO6G9AY98
 2lPZAC572FXmxLQpMUKwfI9txG7JawymBnR4LS5Pv5YcxSQu3uxe+83zCioA==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

The U-Boot Mailing-list is moving to the lists.u-boot-project.org
domain, so update all references of list.denx.de to the new
domain in the main README and MAINTAINERS files.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 MAINTAINERS                   | 2 +-
 README                        | 4 ++--
 tools/u_boot_pylib/gitutil.py | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index e53cb0a485c..b74a0c9ff11 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2002,7 +2002,7 @@ F:	test/py/tests/test_xxd/
 
 THE REST
 M:	Tom Rini <trini@konsulko.com>
-L:	u-boot@lists.denx.de
+L:	u-boot@lists.u-boot-project.org
 Q:	http://patchwork.ozlabs.org/project/uboot/list/
 S:	Maintained
 T:	git https://source.denx.de/u-boot/u-boot.git
diff --git a/README b/README
index 472cf37d9cc..51e98d0f4cf 100644
--- a/README
+++ b/README
@@ -45,9 +45,9 @@ Where to get help:
 
 In case you have questions about, problems with or contributions for
 U-Boot, you should send a message to the U-Boot mailing list at
-<u-boot@lists.denx.de>. There is also an archive of previous traffic
+<u-boot@lists.u-boot-project.org>. There is also an archive of previous traffic
 on the mailing list - please search the archive before asking FAQ's.
-Please see https://lists.denx.de/pipermail/u-boot and
+Please see https://lists.u-boot-project.org/pipermail/u-boot and
 https://marc.info/?l=u-boot
 
 Where to get source code:
diff --git a/tools/u_boot_pylib/gitutil.py b/tools/u_boot_pylib/gitutil.py
index 34b4dbb4839..59688aa7147 100644
--- a/tools/u_boot_pylib/gitutil.py
+++ b/tools/u_boot_pylib/gitutil.py
@@ -528,7 +528,7 @@ send --cc-cmd cc-fname" cover p1 p2'
                   "Please add something like this to a commit\n"
                   "Series-to: Fred Bloggs <f.blogs@napier.co.nz>\n"
                   "Or do something like this\n"
-                  "git config sendemail.to u-boot@lists.denx.de")
+                  "git config sendemail.to u-boot@lists.u-boot-project.org")
             return None
     cc = build_email_list(list(set(series.get('cc')) - set(series.get('to'))),
                           alias, '--cc', warn_on_error)

-- 
2.34.1

