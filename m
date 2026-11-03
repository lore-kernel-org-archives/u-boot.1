Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76776082BDB
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 09:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Epnl0iMC;
	dkim=pass (1024-bit key, unprotected) header.d=maquefel.me header.i=@maquefel.me header.a=rsa-sha256 header.s=mail header.b=oqi8gfc1
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4D5CF40636;
	Tue,  3 Nov 2026 09:53:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qeZhiaRMOPMD; Tue,  3 Nov 2026 09:53:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 78E644060F
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793699631;
	b=Y0L0L3chJE07oKB2cb5aDkY4FrU9ggKlyfCQEZIx+OorFR0Ovje8pxbQMziMyCoIeT8j
	 k8SaIuAXU0EKLmJgSpDKF6XfLz2Ggwuc67rWQgaSNrzZTW9q3h7TED0pEKDRw5jLNsycy
	 oCx7xPRuml0Bw3nT4Ih8BtFt72ooppVXnqPduzOFmA44WJg4/0v6jpxIodzllvXxvxzla
	 2/jWGI9L0OV3RuahogFpi4I+EGmXGojHa/Dvf6mZvIY0d1Orx6YoOE701gEOFd4/UWClt
	 vR8lMmrEtMl9aS+yP+TPFIdlPikomzPsO1t6O5CnnNul6eMHHrRGoGp59nAr/NM5qJQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793699631;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:Received:X-Yandex-Fwd:DKIM-Signature:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=xjlr4Lkoj0f/maMr90IObYY048zoG8y5NfyOAIVQ7OY=;
	b=IhNlH1UGD3gPQ5MNSng5jObMc2rUNkvKELW4E8ERnhw21CXjHnBe7zZpXDR0tICyv423
	 GySbAxGPoniSv9YVYjoP6KVGw7eBTsyvPLm7LXuWKqOp2HsIo2mujlTvXdc4d33IxMRV3
	 bChIkN6TaHx68Bz4EeYnx0+87OYa8ioNiBMg81WCvLryJjrQqRYTFCuZQ+7isKs4ddo5q
	 gKnTnwVI1bgdtNePj3We8vqrzprSt7KVs9ts9Y1n9jtAe/DGOgbAEw4yabvD3wW2QnYrA
	 rdGSBCNqOt4a/1l8lhi1qZgKb+JTROpBEosWLcpZ3BH8KwXjyQG6M+/0MTGZSvVzTbg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793699631;
	bh=xjlr4Lkoj0f/maMr90IObYY048zoG8y5NfyOAIVQ7OY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Epnl0iMCdEISbKemg7PDCuN+XYmc3FF3y/VMuToAbzX16FLC36qHlxkT0SKjHNzT9
	 fWnUMJRexwzrqL8LzyM7lQUIM00RXi4qNU2/ZNsALG+06py6i3ZzQcM2EwiD873pRB
	 pX4T/mUO1WCET4uQ6qeWsWgR5lKu7RpQOcdl5sgF3v7Ks5pivpJ+DSdL2Uv43TzYs3
	 8zwtJ36kVvifk2orC/Oj33Jp2c49SaZIXiEcVhvRVgPQPNEo7K7/3E5i37rPsCn23O
	 ugQsiADPOFzqDGkF2bUFTuM6XbNsYlX6qo2rFeGE/zpBT12GTTC+vz8PZCNvKItAws
	 vhxqlVrSqAcJQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 78E644060F;
	Tue,  3 Nov 2026 09:53:51 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 75A7AD3A
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 09:53:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5B72F606E9
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 09:53:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Rk4lHF-YN0oc for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 09:53:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 7BC9C606A2
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=178.154.239.220
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793699628;
 b=Z72CnFEJuqq2+8Rrfr4/TtggM/hvpeXxyDZ+XDOFybo5yJ4HKbCIlK0P0nOtWSpdOByc
 Qh2IhpVzBmdpiGWRC1eYu1qGRregHFtJwSxfizZdu5J7TuWbfJTKl8fhAItlQaRZfL6zI
 PhVYTU+t+gV+auuIh8I6T7VQxzTerpB62F7gys3GksPAjGOSzfDRtTgjacBWjokl+M46O
 ilwn7aOE1FZ/6ojaYUIVqMOepUbxjik6AVASyO4XZZ+/LhKWjc58vbTPb0wVTrsFZIFDK
 aa+YeBGt3wiPZ43uQD6nrCvWYctPSSBeQW8Yme4QEpXx/n/WX7Q+WZNiZilT2lo0apQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793699628;
 h=Received-SPF:Received:Received:Received:X-Yandex-Fwd:DKIM-Signature:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key;
 bh=xjlr4Lkoj0f/maMr90IObYY048zoG8y5NfyOAIVQ7OY=;
 b=FMT+Z8TS+ahromNnMQN7WBaHn3mXT3RWnDbNxyseRIWlo5HsGNI/m+05ipjS2EfIM3Nm
 F6JgPn0zd/uLsD+JFApszNcagEeQTMpIfMQVUASfE2dIV38JDCyvkBjwZIcR/e0C9MXrJ
 sQHzWxKpYHyty4j0wzfEatlUfXRGIBAerFNzE3JtykPqrGMwk7NuqtWACRvRa/RF09zTA
 44FfZoHAGgC7mPbe/GelpMOUSwiPjIosWIPYcHfg0GcXrj9DGOMP/qs4Kx71NkpaAztd1
 w3WXgnWacz1/7zksqsMipJbUC3wdch3h8xxl4JigVvOKWGujS00jbBHvqumZP2oNXiA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=maquefel.me;
 dkim=pass header.d=maquefel.me header.i=@maquefel.me header.a=rsa-sha256
 header.s=mail header.b=oqi8gfc1; 
 arc=none smtp.remote-ip=178.154.239.220
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=178.154.239.220;
 helo=forward201d.mail.yandex.net; envelope-from=nikita.shubin@maquefel.me;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=maquefel.me
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=maquefel.me header.i=@maquefel.me
 header.a=rsa-sha256 header.s=mail header.b=oqi8gfc1
Received: from forward201d.mail.yandex.net (forward201d.mail.yandex.net
 [178.154.239.220])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7BC9C606A2
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 09:53:47 +0000 (UTC)
Received: from forward103d.mail.yandex.net (forward103d.mail.yandex.net
 [IPv6:2a02:6b8:c41:1300:1:45:d181:d103])
 by forward201d.mail.yandex.net (postfix) with ESMTPS id 6CC0684094
 for <u-boot@lists.u-boot-project.org>; Tue, 03 Nov 2026 12:53:42 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-70
 (mail-nwsmtp-smtp-production-main-70.yp-c.yandex.net)
 by forward103d.mail.yandex.net (postfix) with ESMTPS id 6BF35C009A;
 Tue, 03 Nov 2026 12:53:33 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-70 with ESMTPSA id
 OrH94I7pRiE0-k1g7a7oA; Tue, 03 Nov 2026 12:53:32 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail;
 t=1793699612; bh=xjlr4Lkoj0f/maMr90IObYY048zoG8y5NfyOAIVQ7OY=;
 h=Cc:In-Reply-To:Message-Id:To:Date:References:From:Subject;
 b=oqi8gfc1l32m1x1VqXguuBHLsJZBBxWHDb9se3LpbH3gJx0BF2QS7djmCsX4myWEN
 ZTbZ5V1EXOp3LIzUYZCOdpfRQwq7yrsN7OjYxXVjKYqeU1oIDI+pVqbBoBCZw4qZ0X
 1U1//EcXA3yPO5EjqPxuMkwuDdKb9IHJEbf8S1Is=
Authentication-Results: mail-nwsmtp-smtp-production-main-70;
 dkim=pass header.i=@maquefel.me
From: Nikita Shubin <nikita.shubin@maquefel.me>
Date: Tue, 03 Nov 2026 12:53:03 +0300
Subject: [PATCH v3 4/6] test: spl: Zero spl_image_info
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261103-riscv-full-fit-support-v3-4-e1dcdc9638e5@maquefel.me>
References: <20261103-riscv-full-fit-support-v3-0-e1dcdc9638e5@maquefel.me>
In-Reply-To: <20261103-riscv-full-fit-support-v3-0-e1dcdc9638e5@maquefel.me>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Daniel Golle <daniel@makrotopia.org>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Aristo Chen <aristo.chen@canonical.com>, 
 Francesco Valla <francesco@valla.it>, Anton Ivanov <anton@binarly.io>, 
 Nikita Shubin <nikita.shubin@maquefel.me>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793699606; l=1141;
 i=nikita.shubin@maquefel.me; s=20230718; h=from:subject:message-id;
 bh=JvntnJ6B5cVegAIA97K06YEHVnUH2a9sx7tRl4VP+I8=;
 b=Y4oghE3nmkQwvpOWfh5Z1gBeVlmaVanGbVe3ctcQa6Xl6/u7ZtFdRCJgrZANKnaEEXq39ztze
 cI5IjsdGX3eDn3MzIdHgrHt0OGM7XuHooqwXmArRvJVTM7NS3erFUG8
X-Developer-Key: i=nikita.shubin@maquefel.me; a=ed25519;
 pk=vqf5YIUJ7BJv3EJFaNNxWZgGuMgDH6rwufTLflwU9ac=
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The next patch makes spl_load_fit_image() check spl_image->fdt_addr and
write the loadables into that FDT. With an uninitialised spl_image_info
on the stack this could end up writing to a random address.

Use memset() to make sure spl_image_info is initialised before passing
it, as board_init_r() does.

Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
---
 test/image/spl_load_os.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/test/image/spl_load_os.c b/test/image/spl_load_os.c
index ba9d7979a09..e2b55d66394 100644
--- a/test/image/spl_load_os.c
+++ b/test/image/spl_load_os.c
@@ -15,6 +15,7 @@ static int spl_test_load(struct unit_test_state *uts)
 	struct spl_image_info image;
 	char fname[256];
 
+	memset(&image, 0, sizeof(image));
 	ut_assertok(sandbox_spl_load_fit(fname, sizeof(fname), &image));
 
 	return 0;
@@ -26,6 +27,7 @@ static int spl_test_load_fit_full(struct unit_test_state *uts)
 	struct spl_image_info image;
 	char fname[256];
 
+	memset(&image, 0, sizeof(image));
 	ut_assertok(sandbox_spl_load_fit_full(fname, sizeof(fname), &image));
 
 	return 0;

-- 
2.55.0

