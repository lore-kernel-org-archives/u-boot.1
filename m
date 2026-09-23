Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66C61C982FA
	for <u-boot@archiver.kernel.org>; Wed, 23 Sep 2026 09:35:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8A39E60661;
	Wed, 23 Sep 2026 09:35:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 03uyvZa9XsYC; Wed, 23 Sep 2026 09:35:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 9DA5060667
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790156104;
	b=IB3kk6SkM5Nsa5bbhsX2pkEf+CIbzY5h1EkGPn0QdGjHBhTPNUr9ep0gjVP+1//N+SG3
	 AxtlqkPlwzT462ylUshcruEgn3FzfJUaqAwIJI4yfzkPFUfI8wbweB1Qj0yJW4EF+2APQ
	 IFvr6DgizsnlaAWSVbO/6QVwrOblpl/zI5D75eWu6dqmNx07EkS/cQW4os24BE3OVmnxJ
	 VRf5+Vk0lQVxf3/HnOVD64NY+zehQngMtCf87SyyL6NYBM9vH9dWqwxttWXlo4iwBcpnq
	 GTg2rKtrmEpakYe/0vgODG9iANZnBgl1wc8kVsO8DI1e/zQN2/HqnQc22iDaoAQ/X3Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790156104;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=OKToilGEvfMJ5um1ld9uiM7K3OSYLtn9JVb1KQUdz/Q=;
	b=bgX6d0Cz2rnPUNLAm3jMQR/isxNgit6h26K1fxyYTzHV4aBzDqxsSnIBjTWmJbDBQDeB
	 ipGSqwBnPI9m1TbxvCXqDHdcVs3SBGsjqBn4kDtracbqN9C4wvkZxPslrnMLYQInVEWZG
	 y03O5gpbafcUR3S4RM5koio0AaLA+vUIZVF2fI4wHfkDu32BjzKQ0SgzG/h6ooLgRBjrg
	 mY2dlXU1VK7yWVWn3mCwDY6cfncF0IJiddTvBZDgBtivLTnGIM7vg8ZchnDTAMArC70Zb
	 RVqZrzarY8dRaKrADHTEeuMFpXPPbG0T3vWYGsyowwNp3o2z/aevuqJ83y0uL2wdgTA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790156104;
	bh=OKToilGEvfMJ5um1ld9uiM7K3OSYLtn9JVb1KQUdz/Q=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=JS9hLV3pKqzs+IIsHsJEI2MvfHHGebGZy/cX6hXTYHSIwRUfL36RqC4AVKDTCOX/0
	 wdp/H2VtXAfr8534Bq/Kh2Fwhd6r8yi4pMxXAL1VyMYjtHXKwpgoDigcU6eBVkvR6K
	 Sq4IYfr/drUlp5vXPbLpStGxuDhA6xyQ6hNOdByftI6iKkq98dx3lgSZfdGvi9CXyQ
	 sEa3EizW914zZsUhf6GqBs7c2HwOYaIQJPrAmcQJEA+0wOU0oatOeHHvSphKqgDduu
	 9aOv2plznOgxPVoURsK7BtUsLB0hw+9/AEnVTxLmbP0+XK9lpEENChVh7P4zALcX+k
	 ChJBqhhZdOrkA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9DA5060667;
	Wed, 23 Sep 2026 09:35:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 69115D1
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 09:35:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4BCD880BB9
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 09:35:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aUod8C3IF831 for <u-boot@lists.u-boot-project.org>;
 Wed, 23 Sep 2026 09:35:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 37522808C8
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790156101;
 b=hSiB8GhIFY5hk0s2SxpsIJBTKcJU2Ube3r2+cDH0tSZI9/gwj2oOwk/fCGMr+8FbPEyu
 DBgIQZwcKUfoFAkFthV9gWEpKSJQPLQhIp+Q80dp+IT5a6jtKMTnindR9ZiS+cWYVTgh8
 XcuOj6y4fgAuBssTwmOaWsDipHZxLf0hJy8qIvNw4+1J3b3/o+Pp+lqbF32LZbaK7u7ix
 1d4ktq5gsO4IU6qGTFTbbwk+sseHIwR9g0WS27n6egCtyGmW+8xj/9D4PYjHPBm28CpPX
 OZEy2LfEedBZfWjAkPiiYI5wS3fa9XUg2+Ie9wvBpeq6J7k2vKvmbze8KkQZ6hQsPVQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790156101;
 h=Received-SPF:Received:Received:DKIM-Signature:From:Subject:Date:
 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=OKToilGEvfMJ5um1ld9uiM7K3OSYLtn9JVb1KQUdz/Q=;
 b=XbSI9P8XXCYXPJ+ttFNMVUGaZyAG9UbppnLWDfu9WR3iVf/DavOW11nT++k4gw319mZW
 H4EbT0puqsnJF18mdc9wtNM5V//5YQK/Yz8sF2uqgKUkww4at20jKdpk/Ie4JANF+xhWN
 gF+3ZiRLW4R46SdSHyE1I/1LzWdWj6w14+7yWgiVUZUyBnY3N0pZCrGhpuScZztX+8H0U
 5EOidynkZJG+7EUP8d3kK8EvOA8v+5yurwKiYsPLEIhHR8H6oQkNneYy0exufFemtkTt8
 L2ATnW7IHUO/KvQT2LZB2WDSk+conSx39mqi7MydwrfXGAcqWhQtkuLfxVHoN3l/O5Q==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=SJ8G+Ujl; 
 arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=dlan@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=SJ8G+Ujl
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 37522808C8
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 09:35:00 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 721FF600AA;
 Wed, 23 Sep 2026 09:34:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82E311F000FF;
 Wed, 23 Sep 2026 09:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790156099;
 bh=OKToilGEvfMJ5um1ld9uiM7K3OSYLtn9JVb1KQUdz/Q=;
 h=From:Subject:Date:To:Cc;
 b=SJ8G+UjllFmrqSOYcZtm38HQB+Ilx6I9BmVPzF0Nf1TdIT8kMV5rKe6CgkE+DeLyO
 PxSsf6DnragabiFld3BgfHHLt6NowOEF1dZiUn89wZE0hX+la1jW3gx/Nca0tZAnMp
 m6QcMhpxW+EWdTxqK7gFRgsIykzXMtgPWmOJsMx6YSDiRcWcNix4YVxYNVExYWxDJN
 rwO9IvQLAbtLET00SCH2/TPsD2htmQCuG5iWwl+6RugfegAC8Vh+tqvy/aIZFy38ph
 PWJqaOeFulPnpvk31DhUc6z6UCOI+/RNiydD05nBMDIKSRzAHnRlCeD3I6/Kwm4/wD
 lqdYnes4/zeUg==
From: Yixun Lan <dlan@kernel.org>
Subject: [PATCH v2 0/8] spacemit: k3: add clock and reset support
Date: Wed, 23 Sep 2026 09:34:23 +0000
Message-Id: <20260923-01-k3-clock-reset-support-v2-0-6ec0abb1c7b5@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32NQQ6CMBBFr0Jm7Zi2UEVX3sOwwDpChVAyU4iGc
 HcB49blS/5/bwIh9iRwTiZgGr340C1gdgm4uuwqQn9fGIwyB5WbDJXGJkXXBtcgk1BEGfo+cMR
 c21KpzFpzKGH590wP/9rc1+LLMtye5OIqXBe1lxj4vcVHve5+HfunM2pU6LJUGZvS0Z7cpSHuq
 N0HrqCY5/kDbBrVKNUAAAA=
X-Change-ID: 20260824-01-k3-clock-reset-support-815a0045526a
To: u-boot@lists.u-boot-project.org
Cc: spacemit@lists.linux.dev, u-boot-spacemit@groups.io, 
 Lukasz Majewski <lukma@denx.de>, Tom Rini <trini@konsulko.com>, 
 Junhui Liu <junhui.liu@pigmoral.tech>, 
 Raymond Mao <raymond.mao@riscstar.com>, 
 Guodong Xu <guodong.xu@oss.qualcomm.com>, Peng Fan <peng.fan@nxp.com>, 
 Torsten Duwe <duwe@suse.de>, Ryan Chen <ryan_chen@aspeedtech.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Alexey Charkov <alchark@flipper.net>, 
 Yixun Lan <dlan@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2297; i=dlan@kernel.org;
 h=from:subject:message-id; bh=Va6F/EJUW/nLR1SPH0riVx2N6r3IuxepULm9EXr00Tw=;
 b=owEB6QIW/ZANAwAKATGq6kdZTbvtAcsmYgBqs50jMpVf2WX/iExLxhDhts8SDAig6mKVGQjj+
 XEmGQ0/uYKJAq8EAAEKAJkWIQS1urjJwxtxFWcCI9wxqupHWU277QUCarOdIxsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDJfFIAAAAAALgAoaXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5
 maWZ0aGhvcnNlbWFuLm5ldEI1QkFCOEM5QzMxQjcxMTU2NzAyMjNEQzMxQUFFQTQ3NTk0REJCRU
 QACgkQMarqR1lNu+1SEg//feYO3HHjSfnEgiAl6nNDWOiqMSuqzDnLIFB0RaSLNgyZl1oBAb2lE
 l9AuHQzQjRnoXSBdQkESlEP6H6xE5Ju8YJ+eCvR6DRpZxKiohJ0WWrF+n3d2o1nn/6VRmiS0CHA
 oOuhfzfwg9rdOWYHSatFtWsw+mTXbMImfdlXBxRqJEpvEMgJhDdfjq8I9MOPs9SgT3ea7hT7+TP
 J5v6DLV+J4Q0ClAsWfEK7XoJ2PplkJJoFmkwACyirRfY3yHgzeGu8OH+jgq8HjjmxB43gOX9Q8r
 MGzZXjjBZrGBiGx0cSk4JxkeILJJoCMhSfuwNnUSOO6RUMusqCdwL512WR74Y85VxyZjoljys6D
 10IeE8PyEBXua5LFtuZGFZ0D9knlWT9l0AYpePTKx3vWV2ZsETnAqubY2Dv7qR7Pflwg680jMPK
 CHbuUorj3IHw8of9n/yNrlKi0mX661ZNVNVOawW5g8MmxH9OyBTARoYukwrGqy/FwSUUeup+Nj+
 H5D3DH9oCJsblhDNhfBbM4z33K0acF1w+CRU2ZUCIr0yPfB5/f5qk57UdR8FKvd93xn9E+gW6zp
 LIxiLXJUc1309ONp/KSkylWe8fJJ+IU0NSE4SCOFjDcVf+EcQ2il72dl66B7Ls4cfJQGNmKtg4m
 X72NaFieGwO78DmSowxCXkbUCLu+pY=
X-Developer-Key: i=dlan@kernel.org; a=openpgp;
 fpr=50B03A1A5CBCD33576EF8CD7920C0DBCAABEFD55
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

This series try to add clock and reset driver support for SpacemiT K3 SoC,
the patches are largely based on upstream linux framework.

The reset BITs definition lives in the same register with clock
controller which make them tight coupled, so I'm also putting reset
patches in this series.

Signed-off-by: Yixun Lan <dlan@kernel.org>
---
Changes in v2:
- add complete PLL clock tables
- drop patch for SPL
- Link to v1: https://patch.msgid.link/20260825-01-k3-clock-reset-support-v1-0-c430253e759c@kernel.org

---
Yixun Lan (8):
      clk: spacemit: ccu_mix: fix inverted condition in ccu_mix_trigger_fc()
      clk: spacemit: ccu_mix: add inverted enable gate clock
      clk: spacemit: ccu_pll: add plla type clock
      clk: spacemit: k3: extract common header
      clk: spacemit: k3: add the clock tree
      clk: spacemit: k3: add CPU PLL rate tables
      reset: spacemit: Extract common K1 reset code
      reset: spacemit: Add SpacemiT K3 reset driver

 drivers/clk/spacemit/Kconfig                   |    9 +
 drivers/clk/spacemit/Makefile                  |    1 +
 drivers/clk/spacemit/clk-k3.c                  | 2049 ++++++++++++++++++++++++
 drivers/clk/spacemit/clk_common.h              |    1 +
 drivers/clk/spacemit/clk_mix.c                 |    9 +-
 drivers/clk/spacemit/clk_mix.h                 |   27 +-
 drivers/clk/spacemit/clk_pll.c                 |  124 +-
 drivers/clk/spacemit/clk_pll.h                 |   43 +-
 drivers/reset/Kconfig                          |    1 +
 drivers/reset/Makefile                         |    2 +-
 drivers/reset/spacemit/Kconfig                 |   22 +
 drivers/reset/spacemit/Makefile                |    4 +-
 drivers/reset/spacemit/reset-spacemit-common.c |   93 ++
 drivers/reset/spacemit/reset-spacemit-common.h |   40 +
 drivers/reset/spacemit/reset-spacemit-k1.c     |  128 +-
 drivers/reset/spacemit/reset-spacemit-k3.c     |  242 +++
 include/soc/spacemit/k3-reset.h                |   21 +
 include/soc/spacemit/k3-syscon.h               |  271 ++++
 18 files changed, 2955 insertions(+), 132 deletions(-)
---
base-commit: a06e89ab05eaa2b8344d521319399333cd760ae5
change-id: 20260824-01-k3-clock-reset-support-815a0045526a

Best regards,
--  
Yixun Lan <dlan@kernel.org>

