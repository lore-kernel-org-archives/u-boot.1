Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A424FC44515
	for <u-boot@archiver.kernel.org>; Mon, 20 Jul 2026 08:23:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D12FF841F2;
	Mon, 20 Jul 2026 10:23:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="m4c6Er/Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 73D0480517; Mon, 20 Jul 2026 10:23:38 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B9B6280517
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 10:23:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-495635a85d2so1047885e9.0
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 01:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784535815; x=1785140615; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=d1cjtFZoGMKQsHaIN3qf/ueH6RLLNG67KeSBcWNG+PU=;
 b=m4c6Er/ZP0VMvvH+8AqXURuHcf0cewh6MqRuct2vwq0QsQmX/UnczQ7mpUiQzm/z14
 cCpMQFAOG1viu++6MOlVeIxGcJsRadQcKEh0SEfRfGn9Gdh3es0QdP45SWIzyb+9FgLT
 hExTdnJzPS8Dftf02hsBSBE+pwlvDipmg+GtRLu6OjpJVESlPNfyoAh4GACLtfEzLfIh
 E/6qgRlRvIkKp2y/vO5KkxdQ8Yb+j8hcW8P60/o+sBP8mR8pPxmW7PBaU9yZNvbmxqEB
 GB2DbAjGJMmwgT8K349HUbydMFyAX4J3lKZF26yoBSTZD5VH4vrOroJmPVRRqC5b5Skb
 b4Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784535815; x=1785140615;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=d1cjtFZoGMKQsHaIN3qf/ueH6RLLNG67KeSBcWNG+PU=;
 b=Hv7NUI8S98n/u8zwX1juPOhHt1xq9R1kMYlM3AjfT9HhRi9N0/4S9NTLY4U070mB9X
 3SWOBe4vpjMFSMiT20uNyY/z/+UFIDg99S6uRZcayLLQH72wDU1nfn/4096Rno0xq0QL
 xnmup1U2zSvRN7ZVReaIV/z1TM3L4p04eT71DLKGKd5phQrirvpl7b89pCjJJtsySdYu
 P/SmokV/F2osqPAyqLTNesO0mJXsezS4iwdE5wQvy1uUuuncVtXjV9sUhl7aQck2PiCH
 1ekQ6TBCpCUD5RCRg//HRpJ42xriN6deVj5a2y/f9CCA0wjOgwTDE+in1DcNfi/iGfEn
 V4LQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqb1LztL4qgCCQoW+1B+IAItQVVX4snpWoz+PMhpLBujDfFGRReRed2eeHrRay1alzae+kTuXM=@lists.denx.de
X-Gm-Message-State: AOJu0YwcaSaGK8jR2sSpdcwQocUIZKNCL0n3IIMdBI/c9rZuLO69zS8f
 faeCDUwcaswvIj/5f+fNtfqmeV6dTGUJsY299MJwtJ/W4+saADbgCFgMMaIVcKP+e7Y=
X-Gm-Gg: AfdE7cn0z1mzl8vQdeyMPvfGde2NuulkN8TJWIpvx19LTuf8cYq+tomJ5w8edyQV6PF
 L8XqE8moyLjGPvB1C3xxfXC7/YmXbrdXdzSzPnEN2dIfl/9HQEBbOdWSFBmgGkqThkgTuu8B4yd
 Pv9+bxn8YVrDmknzxygRweXPJchXDO0LUq7u7WM1a82WMbj7ebXj/+9g5arV6W4yTZ6sHGQjTN2
 WLwqn+gMLKlu9xGM70HRRd91ZKwnwSRmRKMrKU7mulm+9SL05t2WK8KKFkmWSFO6OekSIAjeTlv
 hRrZ1UNk9br5yWssUgbdpwbH2pGxCfIr4rcw1cZqFcQ3oBsdQ3YgDWFtNL1ARhPk4wkjrJzkhH5
 EnuH6CeH/e3u2kJ9Be0s/za/qdAxxDbIF8wU+yH87PKKu8ihDhn4RnWO7e9e5lT8K6lgiAR06SE
 G9rcXKBc62CSguggCFkw7tTagh9Rge5pWrIw==
X-Received: by 2002:a05:600c:5247:b0:495:573e:1c54 with SMTP id
 5b1f17b1804b1-495573e1da1mr84022345e9.9.1784535815026; 
 Mon, 20 Jul 2026 01:23:35 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49549c9c940sm242852495e9.13.2026.07.20.01.23.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 01:23:34 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v4 0/3] treewide: migrate to the new mailing-list domain
Date: Mon, 20 Jul 2026 10:23:28 +0200
Message-Id: <20260720-osuosl-ml-switch-v4-0-20ec1c334dd2@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAADbXWoC/4XNTQ6CMBCG4auQrq2hP5TiynsYF6VMoQapaQE1h
 LtbcGGMRpdv8s0zEwrgLQS0SybkYbTBui4G3yRIN6qrAdsqNqIpFamgDLswuNDic4vD1fa6wVJ
 qk3GTgZQcxbOLB2NvK3k4PjsM5Ql0vzjLorGhd/6+/hzJsvvBjwSnWFQFU1mpqMnKfWs75d3W+
 Rot/kj/CTQKVJqKC5AFcPEhsJeQk28CiwKXZU4q0ERR9ibM8/wAdA6k+UcBAAA=
X-Change-ID: 20260623-osuosl-ml-switch-88cf54f5e884
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1933;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=RnPgBMoeVs4uIcGQwA6M3QWQ8qL84EickaJ31WakcnQ=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBqXdsDrvV10VxOK9s+dYyuBeBubhhGHHf50mJwQ1up
 mwxQfJGJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCal3bAwAKCRB33NvayMhJ0fd9D/
 0YYEIwMoTebfEJvfot8BaW3UbNlrPk3GTiixia6LCzYTqTaL7Qn2J7juTKgXTQ5Ns1OnEB2ovdzm1V
 nkw9Xgo5qbzcmdhvBu8KydXP7LRtfNMPqpsSzAdYeK/oNE5r2LB/9mcfHwEH1YLzIPAhc14036/SZQ
 XlnZ9IHeyLbvyWyKSIeNVIkt+XwpPqN51CiN6YAt6OBfRyKIEGLMqZ2aJ1FaQY91NLUmrhPz4KE31P
 V/BtPhiyUkrmbpcDbno16R4wKYyF/y/pDhyZoj2ASJEyS1fPsBZYWdmvIVeo0qdN8Vj+mOv6FQYA9H
 8y46e0HDdv3kaA9qqwLnExLXQqNSD0JeGbdtIEU7Fyco2EC8tcbvacQ/acL0nsEtKlLrixrigC5CSz
 ttLXsCrNv4Kxh+H/0T3o/xOpbBt5RBpouN0WKtUe5Ab2+EixjW0+ap7eDSk4gS2BYFLDc0ycfNPwpE
 E1iv5qn/jPsVkLPnvMRZsEtY8m6dsgu++KcWA5jlCJMp8GM6gwJhf91jchoUNm3MmKw8Nj3UU7qwsF
 /UNB8D/hpVwfVso0iHpVR8lDIhzfnyp0kYDwfjDkcz1bszzcwrNVubZY2veZqEzCIT46ZJcR77HXzU
 uylHlVtJO3WCcWnHGR+Dl9fBcJDfCkAiQ0Q7JUgH7T4howosf3Fp2oF0qY/g==
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

We are migrating to the new U-Boot mailing-list server hosted by
OSU-OSL on the new lists.u-boot-project.org domain.

This changes all references of lists.denx.de in code, comments,
documentation and MAINTAINERS/README files.

Please review closely to ensure the transition goes smoothly.

The exact migration date is expected to be on July 20 2026, see [1].

[1] https://lore.kernel.org/all/20260715173119.GL749385@bill-the-cat/

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Changes in v4:
- dropped RFC
- rebased on main and changed the last links
- reworded for the final migration date
- Link to v3: https://patch.msgid.link/20260713-osuosl-ml-switch-v3-0-48b71dec1a23@linaro.org

Changes in v3:
- Rebased on master
- Dropped the already applied links change
- Link to v2: https://patch.msgid.link/20260623-osuosl-ml-switch-v2-0-28fd46e89e46@linaro.org

Changes in v2:
- Also send to the lists.denx.de list... sorry for the noise
- Link to v1: https://patch.msgid.link/20260623-osuosl-ml-switch-v1-0-6d93a5ba2f5b@linaro.org

---
Neil Armstrong (3):
      tools/patman: Migrate mailing-list to lists.u-boot-project.org
      doc: Migrate mailing-list to lists.u-boot-project.org
      MAINTAINERS/README: Migrate mailing-list to lists.u-boot-project.org

 MAINTAINERS                     |  2 +-
 README                          |  4 ++--
 doc/CONTRIBUTE.rst              |  4 ++--
 doc/develop/security.rst        |  2 +-
 doc/develop/sending_patches.rst | 12 ++++++------
 doc/git-mailrc                  |  2 +-
 doc/index.rst                   |  2 +-
 tools/patman/settings.py        |  2 +-
 tools/u_boot_pylib/gitutil.py   |  2 +-
 9 files changed, 16 insertions(+), 16 deletions(-)
---
base-commit: fdfe2ec48d5c1c2ed03073d73edd3fdd3fe1ffa1
change-id: 20260623-osuosl-ml-switch-88cf54f5e884

Best regards,
--  
Neil Armstrong <neil.armstrong@linaro.org>

