Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C88FCD41D74
	for <u-boot@archiver.kernel.org>; Fri, 12 Dec 2025 00:26:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E7082835B3;
	Fri, 12 Dec 2025 01:26:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=joggee.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=joggee.fr header.i=@joggee.fr header.b="aRbP+xXj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 44CAF835B3; Thu, 11 Dec 2025 22:20:46 +0100 (CET)
Received: from 5.mo560.mail-out.ovh.net (5.mo560.mail-out.ovh.net
 [87.98.181.248])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 15E17839E8
 for <u-boot@lists.denx.de>; Thu, 11 Dec 2025 22:20:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=joggee.fr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jonathan@joggee.fr
Received: from director1.ghost.mail-out.ovh.net (unknown [10.110.37.246])
 by mo560.mail-out.ovh.net (Postfix) with ESMTP id 4dS5974N2WzBK68
 for <u-boot@lists.denx.de>; Thu, 11 Dec 2025 21:20:43 +0000 (UTC)
Received: from ghost-submission-7d8d68f679-mkpf7 (unknown [10.111.182.110])
 by director1.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 4824CC0DB5;
 Thu, 11 Dec 2025 21:20:43 +0000 (UTC)
Received: from joggee.fr ([37.59.142.111])
 by ghost-submission-7d8d68f679-mkpf7 with ESMTPSA
 id O+wFAas1O2mbSw8ATXHgnQ
 (envelope-from <jonathan@joggee.fr>); Thu, 11 Dec 2025 21:20:43 +0000
Authentication-Results: garm.ovh; auth=pass
 (GARM-111S0054169094f-ca2e-4540-8f9e-77cf047c9e2c,
 F56DA505C431942E166043F274A5C1C745DD0766) smtp.auth=jonathan@joggee.fr
X-OVh-ClientIp: 83.204.164.57
From: Jonathan GUILLOT <jonathan@joggee.fr>
To: u-boot@lists.denx.de
Cc: Jonathan GUILLOT <jonathan@joggee.fr>
Subject: [PATCH] cmd: part: Fix part argument description for `part number`
Date: Thu, 11 Dec 2025 22:20:39 +0100
Message-ID: <20251211212039.31628-1-jonathan@joggee.fr>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 3867184709232757772
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: dmFkZTEfslaPbUSr84T+lJNiaibKbzZ9anKQ9vp8D8fuE7C9JIfuIr2x+hRt2mVNSsd/XDAOeosSPnfcuBg0GZCZnDGqswr6A3DdsHO0cVhMaW4Gk03Wu7th/s5ma8CtFw+LhvJbjZU+Xs8nDOQXjdZGOX5Djt+jLzeaZ+zykgGb/4OrFjzqO0HcF7vBNjONh1+g129nU6w3UnZU08ZY654Ndb3W8tgH9T1UY5Gf93YXcC5eoh0qknvKbTt8HmIYdTENw1H2FSrNyYU97tQdaXEvbTUu5BTEHLvuBpmv292ueSlfW9KpiM5iDthY6ruhXwguaC7A0xUmNEU5l13Fq8npKPpehaSlMaplFPpcBXQiMcRv8uP16QlYCb6sqpfV3JNWyihdxpSTmLTxVCU8Sd3eGV5ApTpHGLHV7BYidgH6V/VykSlvK16JEaBmFwzp6/1o399SxLXqtgvG+ZZ/FmXjr1NWARn0L7NTFQJbYsiyfVCWZq7XMPjcYXnaIL54rgutsdVjnZJbK+R14Id8J++KDEuG46nURdcC0gxGk4LS/YEPqZmsWMsl3gB1oBjtfc7Pb3G48QHr+K3dIgTtk2n/8T22+Il5IQnKYZjWRI5HP8BLD407qAhGE/qRI82fB8YzVmGjm4TFrZRhkGKYl/FqCrPAe0LjoB5N3/iKZgetkjPz6Q
DKIM-Signature: a=rsa-sha256; bh=IG16tKrXBKtAIBYwwyt6iCPBdcHKJ/evUBzJ2JNnCgs=; 
 c=relaxed/relaxed; d=joggee.fr; h=From;
 s=ovhmo4398017-selector1; t=1765488043; v=1;
 b=aRbP+xXjbYwc7TV5d48JcGu5eSlhPw/lmxQQom+A7VwyIfzw3vCtOZWkybZn3lMKbzKfPwur
 BEGWtXDVx3+6zrEdtxXc7P1iObYfYWlX+wKiEm6fqdmUkjBYoA8RHwSG2SuWqp5oZF7orBDE8FD
 xvmEDF3oDKDWSuY5AePFt0DUYhiQtS2PTcIA3XdvqG8wYWOmmaAVWQO5qLRa52WM+fEFsOPp2m2
 LiSpW3XlBqoUOEa4UVnN1/X/xjuiwSPt7xL5P3Pp2+n7BjCqiFzx2xcf4Bza7sGRHJ5IczSTVxW
 jCLwyMQQvtjU0NsgFhB/Bsss5k24cJBSQv9EBHh/cml4A==
X-Mailman-Approved-At: Fri, 12 Dec 2025 01:26:18 +0100
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

Signed-off-by: Jonathan GUILLOT <jonathan@joggee.fr>
---
 doc/usage/cmd/part.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/usage/cmd/part.rst b/doc/usage/cmd/part.rst
index 72f5d8b8de7..bd3df15203a 100644
--- a/doc/usage/cmd/part.rst
+++ b/doc/usage/cmd/part.rst
@@ -82,7 +82,7 @@ part must be specified as partition name.
     dev
         device number
     part
-        partition number
+        partition name
     varname
         a variable to store the current partition number value into
 
-- 
2.52.0

