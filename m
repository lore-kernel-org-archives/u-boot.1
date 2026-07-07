Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ADF0C43458
	for <u-boot@archiver.kernel.org>; Tue,  7 Jul 2026 16:38:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA57784A75;
	Tue,  7 Jul 2026 18:37:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=0leil.net header.i=@0leil.net header.b="YaByCCJR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 335A184A35; Tue,  7 Jul 2026 18:09:44 +0200 (CEST)
Received: from smtp-bc0f.mail.infomaniak.ch (smtp-bc0f.mail.infomaniak.ch
 [IPv6:2001:1600:19:fff0::bc0f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EEA68849A4
 for <u-boot@lists.denx.de>; Tue,  7 Jul 2026 18:09:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot@0leil.net
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch
 [10.4.36.108])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4gvmQF3PXdznb;
 Tue,  7 Jul 2026 18:09:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1783440581;
 bh=cE9TUtHxuYVt2GeXVp5afJpVGX9/47VeFh3SF7jaw+A=;
 h=From:Subject:Date:To:Cc:From;
 b=YaByCCJRzDlzLJBFMgcYPPlYR7FHB8MZXqnhP8WFEe6+pC/gVwUgirSrmw3Hd4zfQ
 WiPi9bdzJ01xjNGl7wtXyRlKFJG900JcQLpZlJ6sq3t57fkSgSPwVPB0dhePpU6NqQ
 Zbn/ulvArR+OWkJZxsjFcEiGbZgeTZSERtB/h6HDvx+U6WJ84lV6wk/OJrIVVuQ23s
 +33Lc80ciwwNas16obFe0Ic/GnHR/TRZdoCEz1F/5M4zdnqiskf9csJptu/tqKyP+I
 j5hVP2q2v0a8798rHfyFDLXTcOaZRcqus8dJlxqG0x1+E42Ba5Ret1J5MgoU5mYiyQ
 LpQoWPg2Inl4Q==
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4gvmQC633HzZdt; Tue,  7 Jul 2026 18:09:39 +0200 (CEST)
From: Quentin Schulz <u-boot@0leil.net>
Subject: [PATCH 00/12] MAINTAINERS: update entry for ARM ROCKCHIP
Date: Tue, 07 Jul 2026 18:09:14 +0200
Message-Id: <20260707-rk-custodian-v1-0-dbc9c696e613@0leil.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMTQ5AMBBA4avIrDWpnyCuIhY1HQxJSQeRiLsrl
 t/ivQuEPJNAHV3g6WDhxQUkcQQ4GjeQYhsMqU4LXepS+VnhLtti2TiV5YhVphOyfQ4hWT31fH6
 7pv0tezcRbu8D7vsBHlIZ1HAAAAA=
X-Change-ID: 20260707-rk-custodian-34cc8301edf4
To: u-boot@lists.denx.de
Cc: Heiko Stuebner <heiko@sntech.de>, Jonas Karlman <jonas@kwiboo.se>, 
 Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Simon Glass <sjg@chromium.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Philip Molloy <philip.molloy@analog.com>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Quentin Schulz <u-boot@0leil.net>
X-Mailer: b4 0.15-dev-47773
X-Infomaniak-Routing: alpha
X-Mailman-Approved-At: Tue, 07 Jul 2026 18:37:14 +0200
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

Simplify the ARM ROCKCHIP entry in MAINTAINERS by making extensive use
of the N: regex. For some reason, it slightly modifies the list of
people returned by get_maintainer.pl but I believe the ones reported as
maintainers are still correct.

Add more files under the ARM ROCKCHIP umbrella.

Remove inactive maintainer (Philipp Tomsich).

@Simon, since you don't have permission to push to the Rockchip
custodian tree, I was planning to remove you from Rockchip maintainers
as well to reflect the reality but since you're still an active
reviewer/contributor, maybe you would like to be kept as Rockchip
reviewer (R:)?

Add myself as maintainer.

As could be seen over the last year or so, Rockchip support in U-Boot
has almost ground to a halt with Kever only being able to find time for
his maintainership every few months due to his responsibilities at
Rockchip having changed.
I would like to express thanks to Kever as it is not that often we get
people from the SoC vendor actually contributing to upstream projects,
let alone maintain them. I'm hoping you can keep helping us especially
for things that aren't documented in manuals or for odd behaviors. This
is my reason for still keeping you as maintainer for now, but if you
would like to be switched to Reviewer or dropped entirely from
MAINTAINERS, please let us know. I likely will automatically switch you
to reviewer in a few weeks/months if you aren't migrated to the new
GitLab instance and thus do not have the rights to push to the Rockchip
custodian tree.

I've reviewed Rockchip stuff for a few years already and my current
employer has all its products based on Rockchip for almost 10 years now.
I want to be very clear with what to expect from my maintainership: I am
likely not going to spend substantially more time than I am today
reviewing things, I'm essentially just going to unblock the merging part
of anything Rockchip once they are reviewed. There are many things I'm
unfamiliar with, so I'll likely ask odd questions or clarifications until
I can get some basic knowledge in new areas.
Things aren't going to go faster by themselves so this is also a call to
action. If you do find yourself frustrated because things take time to
get reviewed, please consider spending some time reviewing or testing
other people's patches to help with the global effort. If you do find
yourself in a position where you can spare some time to review or test
things, please feel free to do those things (be it for anything Rockchip
or anything in U-Boot really, or even in FOSS in general).
Finally, I've never been a maintainer and I haven't really figured out
my workflow yet so I'll likely make mistakes and asks many questions in
the beginning, so bear with me and report anything odd or wrong.

@Tom, if/when this gets merged, anything needing to be done in the new
GitLab and/or patchwork to get me the appropriate permissions and
duties? For patchwork, I'm already registered under qschulz. For the new
GitLab, as quentin.schulz.

Signed-off-by: Quentin Schulz <u-boot@0leil.net>
---
Quentin Schulz (12):
      MAINTAINERS: remove redundant entries for ARM ROCKCHIP
      MAINTAINERS: add rkmux.py to ARM ROCKCHIP
      MAINTAINERS: add N: px30 regex to ARM ROCKCHIP
      MAINTAINERS: add N: px5 regex to ARM ROCKCHIP
      MAINTAINERS: add N: rk3 regex to ARM ROCKCHIP
      MAINTAINERS: add N: rk8 regex to ARM ROCKCHIP
      MAINTAINERS: add N: rv11 regex to ARM ROCKCHIP
      MAINTAINERS: add N: rkmtd regex to ARM ROCKCHIP
      MAINTAINERS: add more Rockchip drivers to ARM ROCKCHIP
      MAINTAINERS: add rockusb to ARM ROCKCHIP
      MAINTAINERS: remove Philipp Tomsich from ARM ROCKCHIP maintainers
      MAINTAINERS: add myself as ARM ROCKCHIP maintainer

 MAINTAINERS | 46 ++++++++++++++++++----------------------------
 1 file changed, 18 insertions(+), 28 deletions(-)
---
base-commit: ece349ade2973e220f524ce59e59711cc919263f
change-id: 20260707-rk-custodian-34cc8301edf4

Best regards,
--  
Quentin Schulz <u-boot@0leil.net>

