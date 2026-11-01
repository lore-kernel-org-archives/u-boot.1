Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1FE606A324
	for <u-boot@archiver.kernel.org>; Sun,  1 Nov 2026 05:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Z80kqIra;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jXVwLmcW
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 76287607B0;
	Sun,  1 Nov 2026 05:53:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 91uPVxXpsIGW; Sun,  1 Nov 2026 05:53:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 696C360619
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793512418;
	b=N+GeLdcFiI4YLwDbZPgt51VyEL1dL4RxflD5AlEdOjl4d0SGm06hDObvMZMB0/HeyDbQ
	 qelIhUPHL3qvpZHLb7AfCBeYown+Vagl7xMn3naRfr6L/v3upalZludvgHdhg7TxU6SBO
	 nEdWwJPWXtthEgKubF2XxfFZ85WoEVW6YT6epuGgoZwp+i8u4nwEguUmDbBSkcoKDjWC5
	 wFhXSJ3dyrFfn1rzX/fzbnS0/d+U9UhiS3m32zRrynYOEHpN5jyeX2/iMuUKejj8HquZW
	 8JQswVmZPAOndqsnxlyjcwoGObPS9w0hhnxx7H4a+BBQawgFysM75Ss4VKTAB5CIv1A==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793512418;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:Errors-To;
	bh=A8WoFxCFyn7W/wMS/Mg3ZAhA/wHN2M0bismAZClHpPg=;
	b=HMG2+F+bVtNTqhr8EL3kavNCR0I03wLEHKa4JbmIYd2/0dGaaI/4uknxNGyZi+2r+zcs
	 iZqXX2FRf6NJX/N/HR9e2zTVC4NiDaqMdOAPBbRXMEJFLWBEafmy1d7J58CVwUvJAdWBI
	 pAd2NncuUS5kYsLWEUde8aAILW5iZ0BV31rSF2KuORlvZLeBP6IqoClGLBqKHNoqV+9g+
	 Rz1XpdL/ldPESou3Rp7eXLyPLhyo64GSfBkZN2jttgwdgqdgJ3a5KOpg0eIUqpPGJstwR
	 jzkYmUP99S/RPf5v/sVWmf1YZfuNA6QZS5OmyyGwK1+uKPx4yNisDMdzszdcZM9akEw==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793512418;
	bh=A8WoFxCFyn7W/wMS/Mg3ZAhA/wHN2M0bismAZClHpPg=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:From;
	b=Z80kqIraTIZKcYtHPrBF+eE34AX/eH47dQS0N3mtsCyp0sKIjY1f0/A/5zbST2xKR
	 MqEm56JRULStYt7dEtXFuphxtbsq7qk5iHScomEggCWIFu6DBEA7TZL2vBHTnESqgF
	 ZvZU3s4XQgJGGMrYUoYjcMvCAJvKaHoX9QZncEp4QzG5G8/sbZKvw4+gPhNnoS97oK
	 xJKSQknbVwKGFZ4YGblZVKjaFn3Ef74TBe8TUY9bM1dvW3Ml+fH58RoxJkap8xs/56
	 TmgU/zZeXSkJDf1HQPMzs88OUY269Jn2P3ZYN8BaDHjXHpu67xig+REQNBLRXoIf8s
	 lzvAN4A9ul8zw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 696C360619;
	Sun,  1 Nov 2026 05:53:38 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id E459032A
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 05:53:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D632840647
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 05:53:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id D4_2a8hR6yJL for <u-boot@lists.u-boot-project.org>;
 Sun,  1 Nov 2026 05:53:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D028740753
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793512411;
 b=TzHg1Wmn87jI8fkyN8s4xB+eadNe/LUbm/tmBnP8YgbjnSm5aCY3a1uRVfJOiROfFUaT
 76zh9lx2cEb6U/TRSAAaoB49gCcvX22jzbULDqO0Ge67OE5JsPYUIRXzJtUoCpWwi887/
 SZrBYAB3xzhyYTTtR+nW8IpXRh17zT4V+PG5KSSTKoCg+z7KliMl8HqL+DA1NfmN+5Ugb
 B4rv3zsrureRehN8mcIFu0ajTQcZB6VcuAiFCEp5giEK5ydTmXv7+Pm70hiR3pPJUpXJb
 96tjmfhkCr2uKTyHWYxWhJcITRanLKq9HsKcgrEYKg1akklu3N5QK4JF0xm1p098EUA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793512411;
 h=Received-SPF:Received:Received:DKIM-Signature:Received:From:Subject:
 Date:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
 X-B4-Tracking:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
 X-Endpoint-Received:X-Original-From:Reply-To;
 bh=A8WoFxCFyn7W/wMS/Mg3ZAhA/wHN2M0bismAZClHpPg=;
 b=l7ItZKR22QepqAyZ16wncdfxUadU9eu0Q/7lklJTsWZvgcJfr5xvmidqOGOMJlje3oEt
 z2G+hcVkf4WLETUQhizpyKKNmpFg0vjwKtFkYX/lDsXHH38N1oygdqrrg8GDDUJCAy/t1
 /lC53+//3MQzJ3AGQ+Qdnu9RSE6Isf2iydGenYyR8W9HjfsvsiVja+dSWE5kvx/5q9Zju
 H1ms1e8QtTfhrk946LRnovxSRyjzYER/TJ62LvIId4s++lNM3c2B8MddDXCiQXR0ma15D
 clo/nzZ5msagzdci/bQ+LexveiHaVrJapld6qMXWFgUgEzC+qFFXCqm2ztILLMHPFZw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=jXVwLmcW; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=devnull+iav.iav.lv@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=jXVwLmcW
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D028740753
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 05:53:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 69F3D60054;
 Sun,  1 Nov 2026 05:53:28 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1793512408;
 b=YtYm/9W7uANuGYe4n1Yac0Z29fasUP2Dh0hzcFVW19+49G2Ahmvck6pMbwLgeMB3+Zty
 cIsS1qrQFMZ7zM2SfVRaFGGy8H3G2gbxDiJsRR7jT857nZU22ivQ00Jc0gjneXHbcSsXn
 DMJDeHfKf7Oq89RogAkBxj5T2/egHhaY+g2eNLtsDtUWMA9dyQC3azTF5jtWdxLpOymNF
 V9Jc6EpkU+DkJrxAn2lzI/OTq2IXUuSEiJ+YO/AoaWBG490So7KgjfZ4216pH8++v+gf/
 dM0uKMtYsytr7Mq2UtPV/mf6IGrWOgrZiYuBro3CAqnMJy8FwaYUTQ2l8z1lcbDb6Ww==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1793512408;
 h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To;
 bh=A8WoFxCFyn7W/wMS/Mg3ZAhA/wHN2M0bismAZClHpPg=;
 b=z0XN82E+phPW7jFqf/iY3yr1p68NS200sDJzxyoznZarg/BraW+QSVOJEOT5yYWZ9nDm
 cHHZVP1KUNHLF/YQlkc6J7BaAttKl45kwMCnATmaErm7zNv/m/RKLWQfZskefNJQNVTFA
 EpExx3cjYMMgbis8npljZiJhW/RtX1h4E0nRHS2N/RzX8ISX+TOaspwWsd999NiLAfMOH
 NQAVc6tHhJ2c0mEzdOazBV8Q8WxfGT3R/+t4pFRqm5not5bwYOojEq8VQTxtZiGWrQxx4
 7Rn6xq50VyIe5APUTkUEi0LNajZzC0IsTth3zrFBEo13vo/q7IdnNZIW4CVU6wxnqAQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id A22B21F000C1;
 Sun,  1 Nov 2026 05:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793512408;
 bh=A8WoFxCFyn7W/wMS/Mg3ZAhA/wHN2M0bismAZClHpPg=;
 h=From:Subject:Date:To:Cc:Reply-To;
 b=jXVwLmcW8EZfgRjK8I68+407fhuvb5vcgrpX9zWR6S42NWXnykbLQbfyGh7vlAG5j
 Fqrt8s8cl+kSflBFwYde8tiYSJyzG6Wj+JSWsnWerbsmwwJBHZtExPgFzxTPyDIPGF
 smF0dQyl9u1UuD06q1gQig5kbQ7v2PqyPN2lrlA4mN6TgaXqUUNzzvY9DVzvCfBJTy
 EaOWT/cA8DAVt1dYuy1VTyHOJHeppd5fYjv7p9aXYev9Ezuii9/UlcUUIW/dIVlMsl
 HY+GpD0oirPRpEu/cj8jinj+zZKxITlUXlC3ZZT0iYL5vviACQcetUJ9BHbrE6yuMB
 El81tJOsV3YeQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 27701460B5;
 Sun,  1 Nov 2026 05:53:27 +0000 (UTC)
From: Igor Velkov via B4 Relay <devnull+iav.iav.lv@kernel.org>
Subject: [PATCH 0/4] cmd: lwip: wget: write the download to a block device
Date: Sun, 01 Nov 2026 07:53:22 +0200
Message-Id: <20261101-b4-wget-blk-r4-v1-0-e27a009e4043@iav.lv>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANLT5moC/x3MQQqAIBBA0avIrBvIlJCuEi00RxuKCo0KorsnL
 d/i/wcyJaYMnXgg0cmZt7VAVgLGya6RkH0xNHXTSllLdBqvSAe6Zcak0SgVjFVeaU1Qoj1R4Ps
 f9sP7fh0vZSpgAAAA
To: Jerome Forissier <jerome.forissier@arm.com>, Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Adriano Cordova <adrianox@gmail.com>, u-boot@lists.u-boot-project.org, 
 Igor Velkov <iav@iav.lv>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3141; i=iav@iav.lv;
 h=from:subject:message-id;
 bh=T1UUImtRC3lpa4FcpFhwynJT5smSm8vUcSpCUZ1Vj7Q=;
 b=owGbwMvMwCVmNH1q96v4SmbG02pJDFnPLl+WySy6XRfAvtT9HNvJxAmKbw261Ly2yFpeeiIQs
 e/V+c9SHaUsDGJcDLJiiiwTDmncylhy9a+/h/kDmDmsTCBDGLg4BWAi2nmMDLemsmuszp3A98ts
 Zt6pwodMiZ3Npxi/8LapPD7+6ynLOXVGhufV0XN+fDfdLeK9YeqziJ8xh75w9nrd71KN2NbOH/G
 ohQ8A
X-Developer-Key: i=iav@iav.lv; a=openpgp;
 fpr=90C228DA68A4D5FD4F4837E03297958BEA5F7903
X-Endpoint-Received: by B4 Relay for iav@iav.lv/default with auth_id=1060
X-Original-From: Igor Velkov <iav@iav.lv>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Reply-To: iav@iav.lv
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NUMERIC_HTTP_ADDR,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

wget can write a disk image only after the whole file is in RAM. This
series lets lwIP wget write the download to a block device while it
arrives:

  => wget -o mmc 1 -b 400000 http://192.168.1.65/armbian.img

The target is a whole device, a hardware partition, a partition by
number or name, and an optional byte offset into it.

Patch 1 fixes the buffer size check for a reply without Content-Length;
patch 4 sets that check to the target size, and without the fix such a
reply would be refused. Patch 2 lets a wget client take the data
through a callback, patch 3 adds the block device writer, and patch 4
adds the options to the command.

Tested:
- ROCK Pi 4A: a 1862270976-byte image to the SD card in 3 min 16 s to
  3 min 35 s with a 4 MiB buffer; the first 1862270976 bytes of the
  card have the sha256 of the image, and the card boots. A
  2936012800-byte image, past the Content-Length limit below, took
  4 min 18 s and checks and boots the same way.
- QEMU arm64, virtio-blk: a 404 writes nothing; a file larger than the
  target is refused before any write with Content-Length, and at the
  end of the target without it.
- sandbox: ut lib lib_test_sink_blk; every patch builds on sandbox and
  sandbox64_lwip.

Notes:
- lwIP's http_client.c reads Content-Length through an int, so from
  2 GiB on the length is unknown and a file that does not fit fails
  only at the end of the target.
- EFI HTTP, the other user of check_buffer_size, retries with the
  reported length when it exceeds the buffer (efi_net.c:1715), so a
  reply without Content-Length still ends in a 4 GiB allocation there;
  patch 1 does not change that.
- checkpatch asks for IS_ENABLED() at "#if defined(CONFIG_WGET_STREAM)"
  in cmd/lwip/wget.c; that #if picks lines of the help string, as the
  WGET_CACERT ones next to it do.

gzip and zstd input follow in a separate series on top of this one.

Signed-off-by: Igor Velkov <iav@iav.lv>
---
Igor Velkov (4):
      net: lwip: wget: accept a reply without Content-Length in the size check
      net: lwip: wget: hand the payload to an optional sink
      lib: add a stream sink for block devices
      cmd: lwip: wget: write the download to a block device

 cmd/Kconfig                      |   9 ++
 cmd/lwip/wget.c                  | 107 +++++++++++++++++++++-
 configs/sandbox64_lwip_defconfig |   1 +
 configs/sandbox_defconfig        |   1 +
 doc/usage/cmd/wget.rst           |  43 ++++++++-
 include/net-common.h             |   6 ++
 include/stream_sink.h            |  75 ++++++++++++++++
 lib/Kconfig                      |   8 ++
 lib/Makefile                     |   1 +
 lib/stream_sink.c                | 189 +++++++++++++++++++++++++++++++++++++++
 net/lwip/wget.c                  |  89 +++++++++++++++---
 test/lib/Makefile                |   3 +
 test/lib/stream_sink.c           | 137 ++++++++++++++++++++++++++++
 13 files changed, 655 insertions(+), 14 deletions(-)
---
base-commit: 3401e006432abcbf7d73d7210f10df157f990ed3
change-id: 20261101-b4-wget-blk-r4-833f8a3d344e

Best regards,
-- 
Igor Velkov <iav@iav.lv>


