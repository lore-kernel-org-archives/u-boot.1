Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A753606A31A
	for <u-boot@archiver.kernel.org>; Sat, 24 Oct 2026 22:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=SgBkTDZU;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=sQNBpdtM
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7A0D64068A;
	Sat, 24 Oct 2026 22:35:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tWwPwGf-W_kq; Sat, 24 Oct 2026 22:35:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 1A767406A0
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792881327;
	b=basb3yCeRWZH4uhGuW89bsDV4e9Pv4zzeiZKroaCr4EOfx0inl28rs4mmEy7BJghPECe
	 6GiGoQSKEq6IYRlpjLoxF24rQdLkIdvs0RiA9OqDaRqyb5vInkZKgG3W06co5NhjOCKV2
	 IcYYv1eP030f/8VQc5nH5Bvcidk/EdJsRLHHI9HRzKW8qqX6Leif1fCHBVAnfUPA7sBOe
	 2IsMRV1wKExmENBuFL15E+GRbTGj3tz2IHu8hyP2vFZsQs61J+16n88yvU0FZWz/1gwv0
	 +SxYcrHl3X3DfoFHa/7024I3PGWVK9wYMKiqb0HcFu/BAv0KHs7DOVFmZwSgMPPY1ZA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792881327;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=Eew3dr2KLXp4VXArVqhpOQdetAvnL6dt7OPcfaWh0bw=;
	b=fhH7ckWTwdXFhS2fcTK+Dg7ZrRDvfOfG9odWYfGN1b0Q75lr0+ChTpIhsUidw/vWoiu1
	 mzYvqz/984FdXU3thmIgF2nuRtdzPwXmnJ+qCvAZpYoI3EG0QE7XCZUCorxByvM5XZPG3
	 L9iHQV3vkMl5ybtxKTCas/+U1elEp0Pj4BrrDaGxMvM47kvu/OMctW3lJiVSq/h81jqbw
	 9V86AiYF/3BcIekqvciOR9FAwJ9DlC5pvY4N5EgtqnXQwYpHo54tfPFcF7mOPk6lwHAte
	 ZcUCJXn9MVp74MmU2SL3ztO7zAhahbxNYkh3E4AfmntPsyYq6NK8JOO3BGi25KgCRAA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792881327;
	bh=Eew3dr2KLXp4VXArVqhpOQdetAvnL6dt7OPcfaWh0bw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SgBkTDZUrQXD0roNo1nBnFi0vxyf2YNh2QcsJxx6W41dmzd95bJ5bP3eVR2ykDcPE
	 BB5j+z6SXNLDVhC8wGVYgQR21uFzAg1V3ETclZiBkIlldQWY/MLO+vK1R0uRYv3tvp
	 PXSmWZFP1gCGZKS5J08CbJsoa5r5DUC7I1VsQIYvp1GMCi3prNV8uTeVk2Iz7M61nQ
	 Hpn3MaQpz0gnmZJE1ph1qtg4HAR/KSK1lQh/hPvDs8PH0q+U+G/oT/qtauaKxBC8xJ
	 A+iHfoqw7InrQ8akQUW67fvgyZza2nNE6O72wVIVGNgWX2T2+ukDl0E3mQovs5Kijy
	 LCLMie66009OA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1A767406A0;
	Sat, 24 Oct 2026 22:35:27 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id D39553D9
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 22:35:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B99B46061B
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 22:35:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Mq-h1tuCcmOI for <u-boot@lists.u-boot-project.org>;
 Sat, 24 Oct 2026 22:35:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 4798460613
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c2b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792881322;
 b=bDD5tMNGD8ZefEvmUaKFgkbbfN15T8RVH/CZ7kmMdjXfkpJ0TBtKwMXgKMrrnzvUrGZw
 ngw9lfkv1EpxIQ5TVw/89oMWDIJY+vptAKV/Ddwjo0Hpxn+OctkK/XTXEDt9k6FN7UNSG
 Fvm60zbAcMoKqi1e+fhUcgr+sdAjCT/m8Rtq0QxB7LcHqiuy0M8zVqmV0/UKcNMi/QFlx
 jOJdyk3qtOd+X3u4H+rMwr34Jn2RhHvoXmNbOOfcWcOOAKVpiPm5Xyg3KZeNd2cKgteVO
 oV2du2Zz5lK0ABAnAGl0fzRJTYyyxqYqmdlIJIYhSo1Mp1g9gcKnJapWysUUzpk8oBA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792881322;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer;
 bh=Eew3dr2KLXp4VXArVqhpOQdetAvnL6dt7OPcfaWh0bw=;
 b=jkAvNOTiTBU1VkCNW4v0OIaXTT0tJbqovFzDEcZrzACfWH6K5p6l2qcafcxfQoDYUVua
 x7yy5oLk8BvpLhweKKN7AcqDgOITIbk/UtB067KvtWg3NmIucN+5ZNfozHlpg545IC0cb
 aNZ8tJDKeNjbsTyTwf/Zisw/UMqIvl6hj8j7Ejtk1swC4luKZhutTXnbU7Lm4ah9I/DIT
 u3iORRu6xQJxzstXr3QLZSKAiZrV56NhvegE2pZFG/T+5DiIGKeBDWeXXnn9OOfhqwcb0
 LUA3ezx7kODBHD6GFFtNdZbT9w/M/6ysSBUoS3bPO1F7yiPPus3zELrUzK1OZVTz/0g==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=sQNBpdtM; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c2b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c2b; helo=mail-oo1-xc2b.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=sQNBpdtM
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com
 [IPv6:2607:f8b0:4864:20::c2b])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4798460613
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 22:35:21 +0000 (UTC)
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-6dd4f3f696aso1145306eaf.1
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 15:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792881321; x=1793486121;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Eew3dr2KLXp4VXArVqhpOQdetAvnL6dt7OPcfaWh0bw=;
 b=sQNBpdtMTtGb5nX5cxVh/cOMPPcV5/JJh/0ejJGceqjZtZRqjLbAomJtq2y+sEcsKF
 idUhk9brZczp9+etxxJfhPCYMgM1OsexAICRI/7THmOHGeM4gpC67UYHrc6ZkCfKB1US
 99zjqBh5B3M/zg8P7brWBnPgXdMbehOZAcrdx++N4g28FMaT0HUr+kwEQxXTumTpQBGv
 zENzUKGH31ljMloRLl5LTrAS2MnAi3LSi52Fv+BBd1LSNDjbhpldHcxM9HTwdgBI9Nmu
 z1c56ceCAiOlO0bYgnpUxncs3M916rrzQHdXNtVWwuSxHUTCOhVJ3whr/k3w7Tpove0m
 qEgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792881321; x=1793486121;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Eew3dr2KLXp4VXArVqhpOQdetAvnL6dt7OPcfaWh0bw=;
 b=C1xKcgtIfqIzwJnwzWPbgm6n3BfpYb/oM4+1MPeU6Z2eHqKqR85CHy4FGIHHAswDK5
 nEeEPpHOo978r6adszs5HUfbPZzA3dZTduhjcLdADBcCXe8kmDyoXsgpR/tN2qxZ+Uib
 VGQaSfiLyoPQ5KSRlQ0mNiB8NRtqdpg56Txl6XhGhEgGrb2S5VUHLQofBkEe/wSvBDNW
 Py1CkFLyz/M4CFsKeo/wxyOjn9xyI+cUh0bRwhiGjU6WdCYiQCjtXqlqHbrJVCmdBfHK
 XFTL5w61Sw/rZUfqtzojgOchb5G+9Ftg7i6cScJkt1KfSLlspbfvTs7XgVDUBz5IpLpI
 1YOg==
X-Gm-Message-State: AFq9FYJixSmTJ3ODkbdMBQ43L/tnvrOcaW7rqGMR2JCOvMMtJk9FF1zo
 bcPVzndRA5okyJFjiTRH+/TFi/218gIPRB3cJj7qDRTcmttSIF8dDxC+
X-Gm-Gg: AYBFou3F80H2QfGVAX6/qyKFBVfmJju9I6r/3FctIvdMy4PeMEU22DmLRxXcLaMb+6l
 qai2la76TuBsy4RtBlcr6H4bvMQgelvB1087IdUu/yOY0iN56tBnNe1OvysgRXPb7/7Wtvjryus
 Ra/5qMI//9Nrm630ljcQHAOtvn95DlaIM5R4Z1VZc5T9xP5seuoaw8vdxgsWVR9MD7WwN03ffJI
 sz22IbGPNaPBwB8aNioAtyQFU1Lyl8MearFYHiXR0L3kVDQ8efraJUpN2+ux7vh1H0IRl67mtT7
 ARlSg6l8+ORNjVC8ZOCyelbnC/Yjf+inOMXFHVqM8ZEPqL8S2D4H1J/cQM1+j9JJ8eRRAQo5lkB
 k2Q471k+wvokqmF1mRs99n8vxX1sqUbFj2G6fT+FC1aw1UvrVF+R5qhY/dcA1SMjkb1EttFL4+k
 CE9UnI6qDbHpG/J3jYf3NfQsaiLN8MP0dySpuKqmj948aeFD4jnUIJxGzqRb787kB9UE+JDzSOB
 D8UVGEVTqc31eFaaFsMrGkwFCNRUO2rlzDrbNKIMP7ioBynurwyz/ODmu39zRgiUCLOE/Qx0vJ1
 M1942iW5Awe9ah/HeI28UOttb1DVS4Icu9vGyVgHxrNc3b31NhysyNNIOSJHtwICXwX1G4if7S9
 duChSnr1q+GhuXibmVzjDaAdML66pabI1A+mVnep0WAC7ru2GsfdsEdaprvI+lQZp9FSmi9r8Dc
 fIEKY=
X-Received: by 2002:a05:6870:e0c8:b0:4a6:f51a:7f67 with SMTP id
 586e51a60fabf-4a83f61e54emr1955802fac.43.1792881320821; 
 Sat, 24 Oct 2026 15:35:20 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4a8430d8130sm1706457fac.5.2026.10.24.15.35.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Oct 2026 15:35:20 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sat, 24 Oct 2026 16:34:50 -0600
Subject: [PATCH v2 03/16] net: lwip: tftp: honor transport variables
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261024-submit-lwip-tftp-combined-v1-v2-3-0f663f735ee8@gmail.com>
References: <20261024-submit-lwip-tftp-combined-v1-v2-0-0f663f735ee8@gmail.com>
In-Reply-To: <20261024-submit-lwip-tftp-combined-v1-v2-0-0f663f735ee8@gmail.com>
To: Jerome Forissier <jerome.forissier@arm.com>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Johan Jonker <jbx6244@gmail.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 David Lechner <dlechner@baylibre.com>, Lukasz Majewski <lukma@nabladev.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Igor Opaniuk <igor.opaniuk@gmail.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Peter Robinson <pbrobinson@gmail.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Weijie Gao <weijie.gao@mediatek.com>, Pranav Sanwal <pranav.sanwal@amd.com>, 
 Alexey Charkov <alchark@flipper.net>, 
 Vladimir Oltean <vladimir.oltean@nxp.com>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Drew Kluemke <ankluemk@microsoft.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
X-Mailer: b4 0.15.2
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add an API for binding the client UDP PCB before a transfer. This
lets callers select a source port while retaining lwIP's automatic
ephemeral-port selection when they do not bind one.

The lwIP TFTP command uses a fixed first-response watchdog and ignores
the standard source-port, destination-port, timeout and retry-count
environment variables. The watchdog also duplicates retransmission
handling in the TFTP client.

Configure the client from tftpsrcp, tftpdstp, tftptimeout and
tftptimeoutcountmax. Match the legacy CONFIG_NET_RETRY_COUNT * 2 default.
Make NET_TFTP_VARS available to either network stack and reject timeouts
above lwIP's wrap-safe timer limit.

Keep only the receive server's initial listen timer, using the legacy
five-second interval and CONFIG_NET_RETRY_COUNT * 2 retries for both
listening and accepted transfers. Do not apply client timeout environment
overrides to the server. Its separate inactivity watchdog otherwise
aborts before the TFTP engine has exhausted its retries. Exercise a
receive command that completes after retransmitting ACK 0.

Recognize a server prefix only when it is an IP address or lwIP's empty
placeholder. Preserve other colons in filenames while retaining the
numeric destination-port extension. Retain the allocation base used by
the parser so it can be freed.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 cmd/Kconfig                                       |  21 +-
 lib/lwip/lwip/src/apps/tftp/tftp.c                |  15 ++
 lib/lwip/lwip/src/include/lwip/apps/tftp_client.h |   1 +
 net/lwip/tftp.c                                   | 233 ++++++++++++++--------
 test/dm/lwip_tftp.c                               |  62 +++++-
 5 files changed, 236 insertions(+), 96 deletions(-)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 6cdfcbba32c..fda8568c9de 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -2166,17 +2166,6 @@ config CMD_TFTPPUT
 	help
 	  TFTP put command, for uploading files to a server
 
-config NET_TFTP_VARS
-	bool "Control TFTP timeout and count through environment"
-	depends on CMD_TFTPBOOT
-	default y
-	help
-	  If set, allows controlling the TFTP timeout through the
-	  environment variable tftptimeout, and the TFTP maximum
-	  timeout count through the variable tftptimeoutcountmax.
-	  If unset, timeout and maximum are hard-defined as 1 second
-	  and 10 timouts per TFTP transfer.
-
 config CMD_RARP
 	bool "rarpboot"
 	help
@@ -2237,6 +2226,16 @@ config CMD_WOL
 
 endif  # if NET_LEGACY
 
+config NET_TFTP_VARS
+	bool "Control TFTP transfer options through environment"
+	depends on CMD_TFTPBOOT
+	default y
+	help
+	  Allow tftpblocksize, tftpwindowsize, tftptimeout and
+	  tftptimeoutcountmax to override the TFTP client's compiled-in
+	  block size, receive window, timeout and retry-count defaults.
+	  The receive server uses its compiled-in timeout and retry count.
+
 config CMD_DHCP
 	bool "dhcp"
 	select PROT_DHCP_LWIP if NET_LWIP
diff --git a/lib/lwip/lwip/src/apps/tftp/tftp.c b/lib/lwip/lwip/src/apps/tftp/tftp.c
index 6a8c846cc8a..e3453fa9bfa 100644
--- a/lib/lwip/lwip/src/apps/tftp/tftp.c
+++ b/lib/lwip/lwip/src/apps/tftp/tftp.c
@@ -933,6 +933,21 @@ tftp_set_timeout(u32_t timeout_msecs, u32_t max_retries)
   return ERR_OK;
 }
 
+/** @ingroup tftp
+ * Bind the TFTP client to a local UDP port.
+ * @param port Local UDP port
+ * @return lwIP error code returned by udp_bind()
+ */
+err_t
+tftp_client_bind(u16_t port)
+{
+  LWIP_ERROR("TFTP client is not enabled (tftp_init)",
+             (tftp_state.tftp_mode & LWIP_TFTP_MODE_CLIENT) != 0,
+             return ERR_VAL);
+
+  return udp_bind(tftp_state.upcb, IP_ANY_TYPE, port);
+}
+
 /** @ingroup tftp
  * Deinitialize ("turn off") TFTP client/server.
  */
diff --git a/lib/lwip/lwip/src/include/lwip/apps/tftp_client.h b/lib/lwip/lwip/src/include/lwip/apps/tftp_client.h
index 17fdbb47e4f..6a5019c079b 100644
--- a/lib/lwip/lwip/src/include/lwip/apps/tftp_client.h
+++ b/lib/lwip/lwip/src/include/lwip/apps/tftp_client.h
@@ -44,6 +44,7 @@ enum tftp_transfer_mode {
 };
 
 err_t tftp_init_client(const struct tftp_context* ctx);
+err_t tftp_client_bind(u16_t port);
 void tftp_client_set_blksize(u16_t blksize);
 void tftp_client_set_tsize(u32_t tsize);
 u32_t tftp_client_get_tsize(void);
diff --git a/net/lwip/tftp.c b/net/lwip/tftp.c
index a88073865c1..61a3521c576 100644
--- a/net/lwip/tftp.c
+++ b/net/lwip/tftp.c
@@ -18,10 +18,8 @@
 #include <time.h>
 
 #define PROGRESS_PRINT_STEP_BYTES (10 * 1024)
-/* Max time to wait for first data packet from server */
-#define NO_RSP_TIMEOUT_MS 10000
-/* Max time to wait for an incoming TFTP write request */
-#define TFTPSRV_LISTEN_TIMEOUT_MS 50000
+#define UBOOT_TFTP_TIMEOUT_MS 5000
+#define UBOOT_TFTP_MAX_RETRIES (CONFIG_NET_RETRY_COUNT * 2)
 
 enum done_state {
 	NOT_DONE = 0,
@@ -39,6 +37,7 @@ struct tftp_ctx {
 	enum done_state done;
 	bool is_server;
 	bool wrq_accepted;
+	u32 listen_retries;
 	char fname[TFTP_MAX_FILENAME_LEN + 1];
 };
 
@@ -48,20 +47,6 @@ struct tftp_ctx {
  */
 static struct tftp_ctx *tftpsrv_active_ctx;
 
-static void transfer_timeout(void *arg)
-{
-	struct tftp_ctx *ctx = (struct tftp_ctx *)arg;
-
-	printf("Timeout!\n");
-	ctx->done = FAILURE;
-}
-
-static void restart_transfer_timeout(struct tftp_ctx *ctx)
-{
-	sys_untimeout(transfer_timeout, ctx);
-	sys_timeout(TFTP_TIMEOUT_MSECS, transfer_timeout, ctx);
-}
-
 /**
  * store_block() - copy received data
  *
@@ -129,8 +114,6 @@ static void *tftp_open(const char *fname, const char *mode, u8_t is_write)
 	ctx->wrq_accepted = true;
 	ctx->start_time = get_timer(0);
 	snprintf(ctx->fname, sizeof(ctx->fname), "%s", fname);
-	restart_transfer_timeout(ctx);
-
 	printf("\nReceiving '%s' mode '%s'\n", fname, mode);
 	puts("Loading: ");
 
@@ -143,8 +126,6 @@ static void tftp_close(void *handle)
 	ulong tftp_tsize;
 	ulong elapsed;
 
-	sys_untimeout(transfer_timeout, ctx);
-
 	if (ctx->done == FAILURE || ctx->done == ABORTED) {
 		/* Closing after an error or Ctrl-C */
 		return;
@@ -193,8 +174,6 @@ static int tftp_write(void *handle, struct pbuf *p)
 		}
 	}
 
-	restart_transfer_timeout(ctx);
-
 	return 0;
 }
 
@@ -218,23 +197,15 @@ static const struct tftp_context tftp_context = {
 	tftp_error
 };
 
-static void no_response(void *arg)
-{
-	struct tftp_ctx *ctx = (struct tftp_ctx *)arg;
-
-	if (ctx->size)
-		return;
-
-	printf("Timeout!\n");
-	ctx->done = FAILURE;
-}
-
 static int tftp_loop(struct net_lwip_ctx *net, ulong addr, char *fname,
-		     ip_addr_t srvip, uint16_t srvport)
+		     ip_addr_t srvip, u16 srvport, u16 srcport,
+		     u32 timeout_msecs, u32 max_retries)
 {
 	int blksize = CONFIG_TFTP_BLOCKSIZE;
 	struct tftp_ctx ctx;
 	const char *ep;
+	bool initialized = false;
+	int ret = -1;
 	err_t err;
 
 	if (!fname || addr == 0)
@@ -243,14 +214,9 @@ static int tftp_loop(struct net_lwip_ctx *net, ulong addr, char *fname,
 	if (!srvport)
 		srvport = TFTP_PORT;
 
+	memset(&ctx, 0, sizeof(ctx));
 	ctx.done = NOT_DONE;
-	ctx.size = 0;
-	ctx.block_count = 0;
-	ctx.hash_count = 0;
 	ctx.daddr = addr;
-	ctx.is_server = false;
-	ctx.wrq_accepted = false;
-	ctx.fname[0] = '\0';
 
 	printf("Using %s device\n", net->dev->name);
 	printf("TFTP from server %s; our IP address is %s\n",
@@ -264,8 +230,23 @@ static int tftp_loop(struct net_lwip_ctx *net, ulong addr, char *fname,
 		log_err("tftp_init_client err: %d\n", err);
 		return -1;
 	}
+	initialized = true;
 
-	ep = env_get("tftpblocksize");
+	if (srcport) {
+		err = tftp_client_bind(srcport);
+		if (err != ERR_OK) {
+			log_err("tftp_client_bind err: %d\n", err);
+			goto out_cleanup;
+		}
+	}
+
+	err = tftp_set_timeout(timeout_msecs, max_retries);
+	if (err != ERR_OK) {
+		log_err("tftp_set_timeout err: %d\n", err);
+		goto out_cleanup;
+	}
+
+	ep = IS_ENABLED(CONFIG_NET_TFTP_VARS) ? env_get("tftpblocksize") : NULL;
 	if (ep)
 		blksize = simple_strtol(ep, NULL, 10);
 	tftp_client_set_blksize(blksize);
@@ -275,11 +256,9 @@ static int tftp_loop(struct net_lwip_ctx *net, ulong addr, char *fname,
 	/* might return different errors, like routing problems */
 	if (err != ERR_OK) {
 		printf("tftp_get() error %d\n", err);
-		tftp_cleanup();
-		return -1;
+		goto out_cleanup;
 	}
 
-	sys_timeout(NO_RSP_TIMEOUT_MS, no_response, &ctx);
 	while (!ctx.done) {
 		net_lwip_poll();
 		if (ctrlc()) {
@@ -288,9 +267,10 @@ static int tftp_loop(struct net_lwip_ctx *net, ulong addr, char *fname,
 			break;
 		}
 	}
-	sys_untimeout(no_response, (void *)&ctx);
 
-	tftp_cleanup();
+out_cleanup:
+	if (initialized)
+		tftp_cleanup();
 
 	if (ctx.done == SUCCESS) {
 		if (env_set_hex("fileaddr", addr)) {
@@ -299,10 +279,10 @@ static int tftp_loop(struct net_lwip_ctx *net, ulong addr, char *fname,
 		}
 		efi_set_bootdev("Net", "", fname, map_sysmem(addr, 0),
 				ctx.size);
-		return 0;
+		ret = 0;
 	}
 
-	return -1;
+	return ret;
 }
 
 static void no_request(void *arg)
@@ -312,6 +292,12 @@ static void no_request(void *arg)
 	if (ctx->wrq_accepted)
 		return;
 
+	if (ctx->listen_retries < UBOOT_TFTP_MAX_RETRIES) {
+		ctx->listen_retries++;
+		sys_timeout(UBOOT_TFTP_TIMEOUT_MS, no_request, ctx);
+		return;
+	}
+
 	printf("Timeout!\n");
 	ctx->done = FAILURE;
 }
@@ -348,8 +334,13 @@ static int tftpsrv_loop(struct net_lwip_ctx *net, ulong addr)
 		goto out;
 	}
 
+	/* Legacy tftpsrv uses compiled defaults, not client env overrides. */
+	err = tftp_set_timeout(UBOOT_TFTP_TIMEOUT_MS, UBOOT_TFTP_MAX_RETRIES);
+	if (err != ERR_OK)
+		goto out_cleanup;
+
 	ctx.start_time = get_timer(0);
-	sys_timeout(TFTPSRV_LISTEN_TIMEOUT_MS, no_request, &ctx);
+	sys_timeout(UBOOT_TFTP_TIMEOUT_MS, no_request, &ctx);
 	while (!ctx.done) {
 		net_lwip_poll();
 		if (ctrlc()) {
@@ -358,8 +349,8 @@ static int tftpsrv_loop(struct net_lwip_ctx *net, ulong addr)
 			break;
 		}
 	}
+out_cleanup:
 	sys_untimeout(no_request, &ctx);
-	sys_untimeout(transfer_timeout, &ctx);
 
 	tftp_cleanup();
 
@@ -432,18 +423,22 @@ out:
 int do_tftpb(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 {
 	struct net_lwip_ctx net = {};
+	u32 timeout_msecs = UBOOT_TFTP_TIMEOUT_MS;
+	u32 max_retries = UBOOT_TFTP_MAX_RETRIES;
 	int ret = CMD_RET_SUCCESS;
 	char *arg = NULL;
-	char *words[3] = { };
+	char *arg_copy = NULL;
 	char *fname = NULL;
 	char *server_ip = NULL;
 	char *server_port = NULL;
 	char *end;
 	ip_addr_t srvip;
+	u16 srcport = 0;
 	u16 port = TFTP_PORT;
 	ulong laddr;
 	ulong addr;
-	int i;
+	const char *ep;
+	long value;
 
 	laddr = env_get_ulong("loadaddr", 16, image_load_addr);
 
@@ -463,12 +458,22 @@ int do_tftpb(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 			laddr = addr;
 			fname = env_get("bootfile");
 		} else {
-			arg = strdup(argv[1]);
+			arg_copy = strdup(argv[1]);
+			arg = arg_copy;
+			if (!arg) {
+				ret = CMD_RET_FAILURE;
+				goto out;
+			}
 		}
 		break;
 	case 3:
 		laddr = hextoul(argv[1], NULL);
-		arg = strdup(argv[2]);
+		arg_copy = strdup(argv[2]);
+		arg = arg_copy;
+		if (!arg) {
+			ret = CMD_RET_FAILURE;
+			goto out;
+		}
 		break;
 	default:
 		ret = CMD_RET_USAGE;
@@ -476,29 +481,39 @@ int do_tftpb(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 	}
 
 	if (!arg)
-		arg = net_boot_file_name;
-
-	if (*arg) {
-		/* Parse [ip:[port:]]fname */
-		i = 0;
-		while ((*(words + i) = strsep(&arg, ":")))
-			i++;
-
-		switch (i) {
-		case 3:
-			server_ip = words[0];
-			server_port = words[1];
-			fname = words[2];
-			break;
-		case 2:
-			server_ip = words[0];
-			fname = words[1];
-			break;
-		case 1:
-			fname = words[0];
-			break;
-		default:
-			break;
+		arg = fname;
+	if (arg && *arg) {
+		if (!arg_copy) {
+			arg_copy = strdup(arg);
+			if (!arg_copy) {
+				ret = CMD_RET_FAILURE;
+				goto out;
+			}
+		}
+		fname = arg_copy;
+		end = strchr(fname, ':');
+		if (end) {
+			*end = '\0';
+			/* Like legacy, only an IP address introduces a server.
+			 * Retain the lwIP empty-server and numeric-port extensions,
+			 * but leave other colons in the filename untouched.
+			 */
+			if (!*fname || ipaddr_aton(fname, &srvip)) {
+				server_ip = fname;
+				fname = end + 1;
+				end = strchr(fname, ':');
+				if (end) {
+					*end = '\0';
+					if (strspn(fname, "0123456789") == strlen(fname)) {
+						server_port = fname;
+						fname = end + 1;
+					} else {
+						*end = ':';
+					}
+				}
+			} else {
+				*end = ':';
+			}
 		}
 	}
 
@@ -512,8 +527,58 @@ int do_tftpb(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 		goto out;
 	}
 
-	if (server_port)
-		port = dectoul(server_port, NULL);
+	if (!server_port)
+		server_port = env_get("tftpdstp");
+	if (server_port) {
+		value = simple_strtol(server_port, NULL, 10);
+		if (value < 0 || value > 0xffff) {
+			log_err("error: invalid TFTP destination port\n");
+			ret = CMD_RET_FAILURE;
+			goto out;
+		}
+		port = value;
+	}
+
+	ep = env_get("tftpsrcp");
+	if (ep) {
+		value = simple_strtol(ep, NULL, 10);
+		if (value < 0 || value > 0xffff) {
+			log_err("error: invalid TFTP source port\n");
+			ret = CMD_RET_FAILURE;
+			goto out;
+		}
+		srcport = value;
+	}
+
+	if (IS_ENABLED(CONFIG_NET_TFTP_VARS)) {
+		ep = env_get("tftptimeout");
+		if (ep && *ep) {
+			ulong timeout;
+
+			if (strict_strtoul(ep, 10, &timeout) || timeout > U32_MAX / 4) {
+				log_err("error: invalid TFTP timeout\n");
+				ret = CMD_RET_FAILURE;
+				goto out;
+			}
+			timeout_msecs = timeout;
+		}
+		if (timeout_msecs < 1000) {
+			printf("TFTP timeout (%u ms) too low, set min = 1000 ms\n",
+			       timeout_msecs);
+			timeout_msecs = 1000;
+		}
+
+		ep = env_get("tftptimeoutcountmax");
+		if (ep) {
+			value = simple_strtol(ep, NULL, 10);
+			if (value < 0) {
+				printf("TFTP timeout count max (%ld) negative, set to 0\n",
+				       value);
+				value = 0;
+			}
+			max_retries = value;
+		}
+	}
 
 	if (!ipaddr_aton(server_ip, &srvip)) {
 		log_err("error: ipaddr_aton\n");
@@ -538,13 +603,13 @@ int do_tftpb(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 		goto out;
 	}
 
-	if (tftp_loop(&net, laddr, fname, srvip, port) < 0)
+	if (tftp_loop(&net, laddr, fname, srvip, port, srcport,
+		      timeout_msecs, max_retries) < 0)
 		ret = CMD_RET_FAILURE;
 	else
 		image_load_addr = laddr;
 out:
 	net_lwip_stop(&net);
-	if (arg != net_boot_file_name)
-		free(arg);
+	free(arg_copy);
 	return ret;
 }
diff --git a/test/dm/lwip_tftp.c b/test/dm/lwip_tftp.c
index 7abe4a47d87..4f303276a9b 100644
--- a/test/dm/lwip_tftp.c
+++ b/test/dm/lwip_tftp.c
@@ -1,9 +1,12 @@
 // SPDX-License-Identifier: GPL-2.0+
 /* Copyright 2026 James Hilliard <james.hilliard1@gmail.com> */
 
+#include <command.h>
 #include <dm.h>
 #include <env.h>
+#include <image.h>
 #include <malloc.h>
+#include <mapmem.h>
 #include <net.h>
 #include <time.h>
 #include <asm/unaligned.h>
@@ -24,6 +27,7 @@ struct tftp_protocol_test {
 	unsigned int closed;
 	unsigned int written;
 	unsigned int reads;
+	unsigned int server_phase;
 	int error;
 	int read_error;
 	bool initialized;
@@ -602,11 +606,61 @@ static int tftp_test_server_retries(struct unit_test_state *uts,
 	return 0;
 }
 
+#if IS_ENABLED(CONFIG_CMD_TFTPSRV)
+static void tftp_test_server_input(void *arg)
+{
+	static const char wrq[] = "\000\002file\000octet";
+	static const u8 data[] = { 0, 3, 0, 1, 'a', 'b', 'c' };
+	struct tftp_protocol_test *test = arg;
+
+	if (!test->server_phase++) {
+		test->port = 69;
+		test->error = tftp_test_input(test, wrq, sizeof(wrq), 0);
+		/* Lose DATA 1 long enough for the server to retransmit ACK 0. */
+		timer_test_add_offset(5001);
+		sys_timeout(1, tftp_test_server_input, test);
+	} else {
+		test->error = tftp_test_input(test, data, sizeof(data), 0);
+	}
+}
+
+static int tftp_test_server_command(struct unit_test_state *uts,
+				    struct tftp_protocol_test *test)
+{
+	int ret;
+
+	if (test->initialized)
+		tftp_cleanup();
+	memset(test, 0, sizeof(*test));
+	ipaddr_aton("1.1.2.2", &test->server);
+	ut_assertok(env_set("autostart", "yes"));
+	sys_timeout(1, tftp_test_server_input, test);
+	ret = run_command("tftpsrv 2000000", 0);
+	sys_untimeout(tftp_test_server_input, test);
+	ut_assertok(ret);
+	ut_assertok(test->error);
+	ut_asserteq(2, test->server_phase);
+	ut_asserteq(3, test->sent);
+	ut_asserteq(4, test->opcode);
+	ut_asserteq(1, test->block);
+	ut_asserteq(0x2000000, image_load_addr);
+	ut_asserteq_str("3", env_get("filesize"));
+	ut_asserteq_str("2000000", env_get("fileaddr"));
+	ut_asserteq_str("yes", env_get("autostart"));
+	ut_asserteq_mem("abc", map_sysmem(0x2000000, 3), 3);
+	return 0;
+}
+#endif
+
 static int dm_test_lwip_tftp_protocol(struct unit_test_state *uts)
 {
-	static const char * const vars[] = { "ethact", "ipaddr", "netmask" };
+	static const char * const vars[] = {
+		"ethact", "ipaddr", "netmask", "fileaddr", "filesize", "autostart",
+	};
 	struct tftp_protocol_test test = {};
 	struct net_lwip_ctx net = {};
+	ulong load_addr = image_load_addr;
+	u32 size = net_boot_file_size;
 	char *saved[ARRAY_SIZE(vars)] = {};
 	netif_output_fn output;
 	int i, ret = -ENOMEM;
@@ -644,12 +698,18 @@ static int dm_test_lwip_tftp_protocol(struct unit_test_state *uts)
 		ret = tftp_test_timeout_option(uts, &test);
 	if (!ret)
 		ret = tftp_test_server_retries(uts, &test);
+#if IS_ENABLED(CONFIG_CMD_TFTPSRV)
+	if (!ret)
+		ret = tftp_test_server_command(uts, &test);
+#endif
 	if (test.initialized)
 		tftp_cleanup();
 	net.netif->output = output;
 	tftp_test_active = NULL;
 	net_lwip_stop(&net);
 restore_env:
+	image_load_addr = load_addr;
+	net_boot_file_size = size;
 	for (i = 0; i < ARRAY_SIZE(vars); i++)
 		if (env_set(vars[i], saved[i]))
 			ret = -EINVAL;

-- 
2.53.0

