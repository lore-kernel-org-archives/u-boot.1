Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAF02C83F12
	for <u-boot@archiver.kernel.org>; Mon, 28 Aug 2023 22:02:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 51E2886482;
	Tue, 29 Aug 2023 00:02:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 349048649F; Tue, 29 Aug 2023 00:02:07 +0200 (CEST)
Received: from mout.perfora.net (mout.perfora.net [74.208.4.194])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EA9BE846B8
 for <u-boot@lists.denx.de>; Tue, 29 Aug 2023 00:02:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marcel@ziswiler.com
Received: from toolbox.int.toradex.com ([84.226.64.168]) by mrelay.perfora.net
 (mreueus004 [74.208.5.2]) with ESMTPSA (Nemesis) id
 1Mvan4-1pjc1L27iI-00sdST; Tue, 29 Aug 2023 00:01:57 +0200
From: Marcel Ziswiler <marcel@ziswiler.com>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>
Subject: [PATCH v1 0/2] doc: board: toradex: documentation update
Date: Tue, 29 Aug 2023 00:01:52 +0200
Message-Id: <20230828220154.483362-1-marcel@ziswiler.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:ANMlaORptWX1HJZ348shQa2LoUTkRqya8sv93eOvB455Wwla7WU
 cv/zJCip+IEuQUJMeZicgh4fxBWpnErB8auok0rgGbmCwdo4EL8dPiVpXWfx58KBXamFshw
 58v9IEWOKu06zwT2UrCvNTIHnjWaQNW/QNdoDW/ZN+qlQzS3yZm0SUfKgkv3veTn5gF5WcN
 5UHstVVMH86uokAGbL5Zw==
UI-OutboundReport: notjunk:1;M01:P0:k74G9N4bPfc=;bgXaMNgGjzHXwSw/z4ybSk60QbR
 Ljydyvh0T6zE1Av1L+osWYm4BnsFDWLu0Pk9zmYV5yUagt6z/v5/N4hluhYSIcXR/9ClIhOel
 4Jf++9bJmvTg/to6tlwTPUfvM3IcAFcHrNLrRjbdBijO4B54V24nB/bp9b9/Jzgn7E+Qzozbc
 K8olvMkX1EqJ3DaCh4CxFcfLO0ynkMCvTaQa09IUY5+xLS6VZWpHr1Xc0h+SPllUu4eZdP7vo
 4UZqyE7oIj4ETQFJ6SNSHSZsxTiWVMiRxpfHByN/b//dHhdLTMWZPRcnjhL6XGtzpEQC1qDMp
 +CQbdSmf2nHI+Zy8/FnyyEmOwt4fgtrjs0ye3ZUTY4MUTP9V7Hgfd/9WRIKQvPvDhWgJnJ3h+
 TjTqWXLhyjUWUC/ughl0uprCmBcaNTteABJOnVWmbQZLWUUOskMq6jCb11hC3gwmpgf84TtX7
 Evy3lajcrIqQPAkqTu1qP7BO3MHWp8Wob3hPUNe8f26yDIbf/BJXFboE6n08R+GKdpNI5Qjvx
 jz3JIZczIBlCCwzlNUqG2ceK7/zUMUJSDDHIpWvzQiBSQTOUaHXftyT00qb9/AQUCoOcc2c4T
 jeZCaUIVDkWadcRkUMudHTpPf+L0nfsgkLqRhNJhD+0AMzonOIfMjwyVmvPPVlZ/WU55En7+J
 OVutkbUOyfIUGw1P3oWpG0+HQjkhrtsq+JRGgIG+IbpiW8IpRpSVnCJFW4+0tMuMveAQQtjEu
 ky3o4NC+0xhFfcX2FHGalUfMiUGg0CBLcyjzHSZKGeOLrkVxYMOvuGn4r5BgVxJLuPLMUQHdv
 2uUyTMRPe8FeYQKSCjYmhPqFZaWmIiG5RDhqB+8ur/wiMWIbgQ5cWWVExMvtKrthIOM3AoxMb
 9Vj1/1SpYAtDwZ2wVImqzcZuPqovMOsLh0ks=
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

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>


This series contains some minor documentation updates. The second commit
documents what got discussed here [1] and therefore depends on
Emanuele's series landing first.

[1] https://lore.kernel.org/all/ZOdsX2VMNf20ioFR@francesco-nb.int.toradex.com


Marcel Ziswiler (2):
  doc: board: toradex: minor documentation update
  doc: board: toradex: verdin-am62: document update u-boot wrapper

 doc/board/toradex/apalis-imx8.rst   | 22 +++++++++++++----
 doc/board/toradex/colibri-imx8x.rst | 31 ++++++++++++++++-------
 doc/board/toradex/colibri_imx7.rst  | 38 +++++++++++++++--------------
 doc/board/toradex/verdin-am62.rst   | 22 ++++++++++++++---
 doc/board/toradex/verdin-imx8mm.rst |  9 +++----
 doc/board/toradex/verdin-imx8mp.rst |  9 +++----
 6 files changed, 85 insertions(+), 46 deletions(-)

-- 
2.36.1

