Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA5E5606A319
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 13:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=iPqprB3O;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=McxSqs03
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 73C9B608CB;
	Thu, 22 Oct 2026 13:30:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 28TALFgqADcy; Thu, 22 Oct 2026 13:30:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 744A360787
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792675843;
	b=G8iLIVRS94+rLWWrfGMgYS0VCzD5mSoGsKKvh+jyYI2G4sXXtwBuUxu+yn3B5O49cQFl
	 Hnr7AJVLo82dg1SwT3PwgDAAhDg9OpMO0D6JcBKdnjN3XMebtg6kSfzky5+0A+KBpI0RS
	 A/1X6tcbc5PmnLzwS7GzeoBWWvqSs9Cud3OP0ZotIcvOI0hNwGC+B1PQIiYkgb+zccahL
	 xfQ3ROBg72K6mWZ3+j1KTkyVNQq795C1Oct8dcdTaIx3x77oXDqamxjdLaZs9LRnDCgjT
	 pVCYfj9XlfCCFMK5Y2fpOUjy6Tia+EEJTdoUBWAUw/OJcYcjFBk0iRvvU4ovFyfCeFg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792675843;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=h3VpyHBSzKKqGG7b+uXFU4Pr9zstOHttqlX7oYM85js=;
	b=R/gOX7vZhN0PteN1n2Nnwav4l8hM0yAicoDP+LkyAqhJ85qa/44u+gz0aLWKTbtZBL2J
	 9TKByKA31zkrO7vJEoDYzY/CKXtpdo/VkcRaeD+cNwiIHpHOpgYe8399Fey5XFqQF9Mvy
	 exsTV3Sdvqq2Sqqm5gcWlOqSJyaH1UbBYuoKkIwHHSCzRVzyp1ZccDihelrv2Z2wDuApc
	 yrgiTjzEugbURers8knkQD70ZAO9n2BrEAnbJabwhcj+eyosuZbpxdxq62ZdzdIJZx+6K
	 UqKAtPvCGt/x/XGTAR1Ot0TRigO6X6+u29HDy9dM638U3ppeHQDn9zpEYfisYhLgjBA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792675843;
	bh=h3VpyHBSzKKqGG7b+uXFU4Pr9zstOHttqlX7oYM85js=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=iPqprB3OvjrPvBp7p769eI8aAFwRnlZ2IE1X8FyuDmgIUQ9PvmeKb9+t2dh2jSWKQ
	 RWpIfYPu+WcYp7fyh9D92XPDyvjUchgAfSxCjZRzvoA33GKyf9ufxdnlgIFtZjEAj1
	 d5nrwGH/OC6o50Qu6q1QAUmF95KSVoZuCO0O0o77lZRXEbbHbs3MUFuyaD7EJMFeS/
	 pA5MmN+4+1j6sh5pNDkTLlVH8EYO5ZU+RmaWxrWhaUwOb4gjF9DiaHqen0jc4HhvVj
	 EDrT9jv6HDVYiJWUNVMjkWJc2LiNN8KFaNOupkQqbbeayhk8fm3TWZlaB4b0JcvhSZ
	 2vpCXArt2z2qw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 744A360787;
	Thu, 22 Oct 2026 13:30:43 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id A906A3AF
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 13:30:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9AA6F8121A
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 13:30:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6vnzlSMe_BSn for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 13:30:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 9129081176
Authentication-Results: smtp1.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792675841;
 b=rbhKHxGY10pYYOuOd3YubrJqjMR93kjEpx8GmD1+ROjqeSQNkJC8LxxCZJkUVH0W5Ylj
 PLJoIsuDYfxh7fEAiv3zMJhkoDyFEX0QsZCB8AiUh7+C/cA9cjd1XBY7MQab9k1LaXx90
 J2kRQUK6IxoHnpUPHkkZtV7+Z91/D+oS2HgOasJFfNv0ccD9+mMYsoulkSFL9cGH4eVHK
 RX6+ZshChT7Z626eBLTJ1WhKGuSbEi8zoIInfiqY46aAniRFj9Tx/npLanWHmeAkVVaa6
 1sRfsCMr380WSw9phtUYA371BTzzk2VN0SYblCw58X3v/5mS50C+ZYOZXDuCIj+5NzA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792675841;
 h=Received-SPF:Received:Received:DKIM-Signature:From:Subject:Date:
 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=h3VpyHBSzKKqGG7b+uXFU4Pr9zstOHttqlX7oYM85js=;
 b=Odjepb4sC5XmpIUk/px9bPDfP93ZDgTZadK8PBTEzQabQRTLUE7KuLngf7/eLKTQIgkM
 Va/KQHjdSSFCZ8hjkXvhm07fRQgf82IxBwKYT+V8Z8ZvB5pRaxTSrSBkc1W3idIBL6TUF
 G0NtIfz8J4/3ytca2+n6yt1IiAvOkl6gVVwOGf/771Zkf147HP4cSdLXUHsy1wKrMLDuO
 aL2l2C40i1YyQ+iEAHcQbZcuCx75bID3IY8bN333ViEyU0uK3OPDhHVcJVk47H3gAQoEl
 N4oH6WBjPbFY8SKiydcD1KDjM0CNY3mP/E2x/vfS4tVideQapO5ibRRW3ng7xtLalPA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=McxSqs03; 
 arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=mkorpershoek@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=McxSqs03
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9129081176
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 13:30:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 35A5241E5A;
 Thu, 22 Oct 2026 13:30:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98DBC1F000C1;
 Thu, 22 Oct 2026 13:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792675840;
 bh=h3VpyHBSzKKqGG7b+uXFU4Pr9zstOHttqlX7oYM85js=;
 h=From:Subject:Date:To:Cc;
 b=McxSqs03qL0k3BAD7dlhcfDyUtVlRbO25Vtn6/5AP+3FPhs3yt536YomLl/b3mHZW
 cok7m2bk/CGvXBpi0KcdSIoXqyO1/wfNHZA6dgKZHpjIS/s6N3E42WASjXdccp/E7/
 6cdqHEHdojWJ7vTYixTYDqb5aw2QUA0+PaPdGItMB1BQ1RAlc/0ipgwRu81XTJlIdD
 AvAfC8k1+KnOEeV7vcW5RkAz6EOkfHBACNfussm16s2bFvUjEj8xQaiE9Tfux+bIaT
 +lqT+eS7X6f+Srycz+S/w6n6GHb8mWI8rrpRL9pkhjUdjnnbWKtJpl9N829YLUFr2K
 ClMpd/fcaagBg==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
Subject: [PATCH v3 00/10] Fix AVB pytest suite for sandbox
Date: Thu, 22 Oct 2026 15:30:29 +0200
Message-Id: <20261022-test-avb-fixes-v3-0-d3a6ff9ba097@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3XMQQ6CMBCF4auYWTumHVpoXXkP4wJkCo0GTEsaD
 eHuFlYa4/LN5PtniBw8RzjuZgicfPTjkEex38G1r4eO0bd5AwkqpZAaJ44T1qlB558c0daqNMR
 G6KqFjB6Bt0c250vevY/TGF5bP8n1+jeVJAq0rBtDpVKFtqcbh4HvhzF0sLYSfXgSP55Wbytnn
 FCuLdyXX5blDWMysdTtAAAA
X-Change-ID: 20261015-test-avb-fixes-9a4682e8057d
To: Igor Opaniuk <igor.opaniuk@gmail.com>, u-boot@lists.u-boot-project.org
Cc: Jan Kehren <jan.kehren@emteria.com>, 
 Guillaume La Roque <glaroque@baylibre.com>, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2382;
 i=mkorpershoek@kernel.org; h=from:subject:message-id;
 bh=coGwVSNG6/Q3qmeFa9iwD7QR0adcthVxsKroOFr5b0Q=;
 b=owEBbQGS/pANAwAKARkNHbRmThk1AcsmYgBq2g/4iN1X6tWHvUVtzSgfISwxFqkdXpDmo3BTT
 2i5sGK+MJqJATMEAAEKAB0WIQQu6UKnth9qvlMTrQAZDR20Zk4ZNQUCatoP+AAKCRAZDR20Zk4Z
 NUojB/0W9tnEYg17fOLCTsrXepbx+fK1Ou4C4j48TG2/ro18yG+7EhE3DnJ69rRPfIg56h3i/bx
 ChhwDRcvThrSHSsKd30ADMEcoZ1GOyGjkELzCPMm3+s8IaKlyAXhJYhbMIRuMYMbm+MxczWEz17
 yBits0Z5TI0WCtpc9W+Ll87er3k1a3ksthoQBs2M/pFTVriRWVaFyFm9mlEKZcGNksOjL6acBXE
 hqLIW58RILHnbO8u/ZCHeAkXiXQjDMiDDNUYUHtt/F9/ZneJZyErAFqPO1wVz3qQ+yNVjb8WLdB
 DCh7UrusPQj+RkwpuFTnnt+VIaoWsugLhytA6eeFq5YtUh9b
X-Developer-Key: i=mkorpershoek@kernel.org; a=openpgp;
 fpr=8234A35B45C0D26B31C1A2DA570338B018144F28
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The AVB tests have the following limitations on sandbox:

* The mmc1.img required by sandbox is not created when the avb test runs
* mmc1.img contains a Fedora image, so avb verification cannot be done
* The tests silently pass due to bad usage of string.find()

This series improve the test suite to have more useful results on
sandbox.

Signed-off-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
---
Changes in v3:
- Fix typo in commit message for PATCH 10/10 (Simon)
- Drop U-Boot restart in sandbox tests (Simon)
- Add error handling on bind /mmc12 (Simon)
- Use unbind /mmc12 on teardown using yield (Simon)
- Add docstring for create_gpt_image (Simon)
- Link to v2: https://patch.msgid.link/20261020-test-avb-fixes-v2-0-997f8f04fd3f@kernel.org

Changes in v2:
- Add missing find() return code check in test_avb_mmc_uuid (Guillaume)
- Skip avb tests when qemu-img or cgpt is not installed (Igor)
- Link to v1: https://lore.kernel.org/r/20261015-test-avb-fixes-v1-0-9e5b82644359@kernel.org

---
Mattijs Korpershoek (10):
      avb: Use map_to_sysmem() for flush_cache() address
      test/py: android: Move android image creation to a dedicated file
      test/py: android: Drop verbose printing and unused return
      test/py: android: Use for loop to create the images / update disks
      test/py: android: Add create_gpt_image() for image creation
      test/py: android: Add setup_android_v{4,2}_image subfunctions
      test/py: avb: Use format specifiers instead of str() for mmc_dev
      test/py: avb: Move mmc device number to a pytest fixture
      test/py: avb: Add sandbox AVB testing with dedicated mmc12 device
      test/py: avb: Fix find() logic when matching response strings

 arch/sandbox/dts/test.dts                   |   8 ++
 common/avb_verify.c                         |   3 +-
 test/py/tests/test_android/android_image.py | 116 +++++++++++++++++++++++++
 test/py/tests/test_android/test_abootimg.py |  77 +++++++++++++++++
 test/py/tests/test_android/test_avb.py      |  81 +++++++++++------
 test/py/tests/test_ut.py                    | 129 +---------------------------
 6 files changed, 261 insertions(+), 153 deletions(-)
---
base-commit: fed92546960a92177d67c0b8d7b22385f50fed29
change-id: 20261015-test-avb-fixes-9a4682e8057d

Best regards,
--  
Mattijs Korpershoek <mkorpershoek@kernel.org>

