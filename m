Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F418CA5FAB
	for <u-boot@archiver.kernel.org>; Tue, 29 Sep 2026 00:22:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 65E386070C;
	Tue, 29 Sep 2026 00:22:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZskaeAOtpns4; Tue, 29 Sep 2026 00:22:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org A928F60738
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790641358;
	b=R+9dPKm5jNgsu9BSK+yF/nw7zHJha4OCNs6PqgVqWG1lTwniYHwVLgsttIFDizbrhtWh
	 Ckihh8QQwwSlZtlYU7nDvxP1ll2A4HMT2bDe1NdGfb0bAu7uv3r8JbYbLtIK3fqiYC++c
	 R9CTG2W++OE8PA7k5OrZePEOrcLGL8GADylsaokpA91x3sr3+jU9fw5woWR1nU5iAAIb6
	 1hm0UGUabMpwniuGMOql1XONl0FANQZ4AVEb9x+NqKMxLYqn9gqCsyOcfzznR4BpZd8Nz
	 Bcexzjq9YRz0i0Fy4tpeR+7PWif4H+g2TOCidLjtL927hnW1g6HfqvcHjTaWRraVyug==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790641358;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=Puo/rq7GOPzenUv4PB9pz/ZoVSFT3F8oyNhdrO1RX80=;
	b=az+1TXkv3G4ikrsVAfRO/HtpfPFltf4uPkl80caGKHXwW0dMOHMoBQ4AzsRVrvWVGuqf
	 DsTeDX1Sl+FUQYh4m8k/VI/OvGCU95nUfoW/f2WUJa6sUxvGeCk8ectOmbv3biZ04sTWO
	 cQdFz1bOHutdFL8S4wlXFFfHRD3G5f85SDAR6T3f0ZrJYMkcJbGrPPY6KF++eQSu23P7I
	 rg15duw59AmDernG22EYdKp617od3jqoCTdAkThv7uYu3TQNOYjnqZ5pJrFpgjxfZUTxV
	 H8boUonk5jnQKup7gY50f0sBb1ZoUNm7q5MbaSCYbpPJcoHCfIlZrAgEorGqvn5TbJA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790641358;
	bh=Puo/rq7GOPzenUv4PB9pz/ZoVSFT3F8oyNhdrO1RX80=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=I9WxKbohjg6FFEZ9yqYygYjdQYqiThoa8yq8tJScSPvL5nG1MGuNqoxaEQgug9ckU
	 62lIAJJ7JxK0DXKMXRrpXWufPS3vne3McaDpYu9j8TxIuluKMm7CpQAF4reNl4zjq+
	 mGCN7dCgVLkhwQaBZYLQuOE5reFpK1H1rvgZZcVyOVzoJJC7Bq18JSAC2Gs7EMN+Vt
	 nh+MNfWbTVobtZ4u4bqYkMz7DWBVBjE/E78J/wdJV62GjGRaequscgXYMHkLRXQbcM
	 bjb8KNhufiob9KiCqxyyUuZV+sh3fc/FWqfTzZ5JcozALsF7dW3pJBR5hi6FFjKcKw
	 cAiKF5nn/32VQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A928F60738;
	Tue, 29 Sep 2026 00:22:38 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id F0A39417
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 00:22:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E110480646
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 00:22:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QZDI2fHSXsSe for <u-boot@lists.u-boot-project.org>;
 Tue, 29 Sep 2026 00:22:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 76C148070F
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::e"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790641348;
 b=VstQ1uK5m4EOfjsxh3FiQbdNgVe4SuUwKNKMrtE79nQ+6B8Z1zMpXKx6qHTS4P6GdNjs
 UX/JtEKDEYjJJzNWqQOLUOY4svnr+Y8rYfdjOQmvXrw2cL6IPGwkdzJsKvLE6jIbC1DXK
 CY+k2poy0/NCK6Bi3mUYUj6mfoHfBFV51kvLTtM7BNbJ45o7VCcn9pA6wErWqG9GiEczA
 3eJuw9OcQSIUyx8+aypoNqJsqPgwoqBu5Pq/ZtMwk5ZREU//K+qbc6GB9B1clHSf0O2Rx
 6NcITZ1rkR7fZR9W8P1pq5/C6Wsx3rhLVPetUdJoj2fTNISTTzLAGPvE29FMpWxTLGw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790641348;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer;
 bh=Puo/rq7GOPzenUv4PB9pz/ZoVSFT3F8oyNhdrO1RX80=;
 b=jWcQlTzCxgE4C1MT6FC0RXBgo64qrKyF1kW7ADTgpBEV9XzVGaqHEmmcDSou2Kd3zKpe
 cY14FmFMfus5rDRL9VdbUj417TvNRh0Jkngy2NSKMSgHC7XAKZ74UCTDuoKhgcp4LxY9F
 tsuvHtlXU+o7WaHJU4hsWId43SPM0d7L059kV4DkpO3FAr4aVuNVXUaNYK9KEb3o6kJtE
 stcwtK4xrvJHC3M/jzHmr4X9WTIk0K9uyUI++xrHSDi2OwYH9TjImsKxH8OLieHyz3ch7
 VpIctLr2IT/y/v/MAzP+oVVeMpOP04UjGPHmnznk7jbqcKwgG/0795Uycw3cC8jjqzA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=Lq0mNPZF; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::e"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:31::e;
 helo=mail-oo2-x0e.google.com; envelope-from=james.hilliard1@gmail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=Lq0mNPZF
Received: from mail-oo2-x0e.google.com (mail-oo2-x0e.google.com
 [IPv6:2607:f8b0:4864:31::e])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 76C148070F
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 00:22:28 +0000 (UTC)
Received: by mail-oo2-x0e.google.com with SMTP id
 46e09a7af769-81be26ba237so1055392a34.0
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 17:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790641347; x=1791246147;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Puo/rq7GOPzenUv4PB9pz/ZoVSFT3F8oyNhdrO1RX80=;
 b=Lq0mNPZF6J0Ee+bQUu2GbNvdVhZLkdvZvRmItDDl3SptZxtx34WH3ZoYWYQe8DiSil
 I6NsDCi5WlAZD6Xd/zHnTff/VfOg61nU659Icj6VjVJNtXfYE3QXXj0m3GtxjzbTHM4s
 tEM/nxgVRMYiWsFoK0JssmTqI68t5koTZtb3t+zM8EM32WIlvzKj9k8Nhk8cQnLfSBg3
 USGMu1ODz9Blw/e3jmz75qUYL60OBebEATrk8Ch5la1zivPeHfaUfCLBJmxkZyw6C51c
 8yuaBh/Kj1pXTgL5iZrPC92vnAW/ykw56DLIaGzojvunS6AdMP204CfziaQazaJGnWB5
 1QvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790641347; x=1791246147;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Puo/rq7GOPzenUv4PB9pz/ZoVSFT3F8oyNhdrO1RX80=;
 b=IKYUgaF5uBvXsjwFgd71kk47KRV9hRKQZ2pdGJfbPO6IQ1bml9XllHdsc087Gj0/R2
 YivJrC/OAX+8vAwJPUWXts2Ni9u3m81upBHRfYit3hLVfiLoizoaI4lX34TwM7HjIIvs
 gNh3wsReUyD5FMcgL6VoxJ/zfaNAuF8l9CMJOv48MRdgIXJiQBoBwIhWJAGsQDOgcOET
 yBLy89Awp+6M8ZHcHnE+GEdBASlgzJ6InybMQh7pp4rQBQVm9QIObAwPp4lM06sgSmMG
 AmzOMKG/1fxFzSJ5zALARDMPZikFLcgcq3EKf1sQ9s68RFu+tM5r8br2VmeN6IqMNFEz
 Y8EQ==
X-Gm-Message-State: AFuF++kACLevpRhfzmL18ka9GkAuluoyNx+SZsmR/vGV42eJ9mSqhQl6
 pgwvjxzy8a9JQb7yl5fuwfBAGDyoXFkeP850dhtpYxHx/SGawpOhFmcg
X-Gm-Gg: AYBFou04gAgOXh4saYCA6FpkJsb2vgBsVcwiDJcsPULjQxkWbGuOHgcXRK/Xv0Yiv2x
 dk8pUtnPncfg5V2iXtBcWBD6mW2k2bSmrvRo0df6FcBqOIdJ1jndK+9WJ3/NvyRt13D3DrI+OnU
 lrPM56KTiJa3JR19UUMVND3ni/DKAVEZYqLl6en9j2LDew+IRSd6tGBk3jO/RNoSm4pc2axN1ET
 siPaXNw9Q3OahHLN8LO3lAsowQ5JReWmLktpGgFwVK7kOD+i2dA6bLK8Q451cROY7Jn2OsCRfZ+
 Z1Yq0pIpeTbFUYx9f3LjmoaIomClPIAWerzT82XUfWlJs/TIZ717i0YRP8INOvP1fi8+GdmA8CY
 0Q4N5bbhIZV3fm57HZgC4sOLJmBPfTmqXnV/cFdefBoEYSGJ1WRBy/MkXyxDdQpAdBbZg8N2LDq
 gf2PzcN8Fr2ZBy2Y+TX0y6t9kbVgsHzOGIr9vdsBb6KKA/gZ2gMTyhgYPcI4a8aEzg07PQd27kI
 80e2lYbTdaV6nDiYaiY5BQwupiocvCb9UF32kbCp8scHbF3ppgit8Qo9mseoal+e8sE0wQzAFI5
 Ju1REqkT6kxkjaTSs+W1TdoANf9Q0RNxsZgQFhEKv5Hq+ALMYIq6nTFTiynKS8E08T+IC1td+jh
 ETM0C63AmAzo8I2cb/jCl
X-Received: by 2002:a05:6820:4b17:b0:6c1:fd93:528e with SMTP id
 006d021491bc7-6d43f2c5a45mr13986043eaf.31.1790641346891; 
 Mon, 28 Sep 2026 17:22:26 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-494877590e5sm8175688fac.13.2026.09.28.17.22.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 17:22:26 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 28 Sep 2026 18:21:56 -0600
Subject: [PATCH 19/20] net: lwip: support standalone BOOTP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-lwip-dhcp-v1-v1-19-2060c7365b0c@gmail.com>
References: <20260928-lwip-dhcp-v1-v1-0-2060c7365b0c@gmail.com>
In-Reply-To: <20260928-lwip-dhcp-v1-v1-0-2060c7365b0c@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Michal Simek <michal.simek@amd.com>, Johan Jonker <jbx6244@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Francois Berder <fberder@outlook.fr>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, Peter Robinson <pbrobinson@gmail.com>, 
 David Lechner <dlechner@baylibre.com>, 
 Shahriyar Jalayeri <shahriyar@byteray.co.uk>, 
 Heiko Schocher <hs@nabladev.com>, Pranav Tilak <pranav.vinaytilak@amd.com>, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2
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

CMD_BOOTP is restricted to the legacy stack even though lwIP provides
the UDP transport needed for a BOOTP client. Expose it for lwIP and
implement the request/reply exchange independently of the DHCP state
machine. Allow either command to be built on its own, selecting only
UDP for BOOTP.

Send BOOTREQUEST with the requested filename, elapsed time and
configured RFC 1048 tags. Retain the transaction ID across
retransmissions and accept both plain BOOTP replies and RFC 1048
extensions, including unicast replies received before the interface has
an address. Validate reply identity and option lengths before
publishing the assignment. Do not mistake a DHCP OFFER or ACK for a
BOOTP assignment.

Share the existing boot metadata parsing, environment publication,
timing, interface retry and autoload paths. Keep the BOOTP server from
a nonzero siaddr rather than substituting a relay's source address.
Leave the configured server unchanged when siaddr is zero and clear
stale TFTP server overrides. Preserve configured defaults when a plain
reply supplies no subnet mask or gateway. Remove the UDP callback
before retry, download handoff or runtime release.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 cmd/Kconfig                |   5 +-
 cmd/lwip/Makefile          |   1 +
 cmd/lwip/bootp.c           |   8 ++
 include/net-lwip.h         |   1 +
 lib/lwip/u-boot/lwipopts.h |  12 +-
 net/lwip/Makefile          |   4 +-
 net/lwip/dhcp.c            | 268 +++++++++++++++++++++++++++++++++++++++++----
 7 files changed, 274 insertions(+), 25 deletions(-)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 975b8374832..0c184df8288 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -1969,14 +1969,15 @@ menuconfig CMD_NET
 
 if CMD_NET
 
-if NET_LEGACY
-
 config CMD_BOOTP
 	bool "bootp"
 	default y
+	select PROT_UDP_LWIP if NET_LWIP
 	help
 	  bootp - boot image via network using BOOTP/TFTP protocol
 
+if NET_LEGACY
+
 config CMD_DHCP6
 	bool "dhcp6"
 	depends on IPV6
diff --git a/cmd/lwip/Makefile b/cmd/lwip/Makefile
index 245683a9672..a60f8f35200 100644
--- a/cmd/lwip/Makefile
+++ b/cmd/lwip/Makefile
@@ -1,3 +1,4 @@
+obj-$(CONFIG_CMD_BOOTP) += bootp.o
 obj-$(CONFIG_CMD_DHCP) += dhcp.o
 obj-$(CONFIG_CMD_DNS) += dns.o
 obj-$(CONFIG_CMD_NFS) += nfs.o
diff --git a/cmd/lwip/bootp.c b/cmd/lwip/bootp.c
new file mode 100644
index 00000000000..20b184b6293
--- /dev/null
+++ b/cmd/lwip/bootp.c
@@ -0,0 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#include <command.h>
+#include <net.h>
+
+U_BOOT_CMD(bootp, 3, 1, do_bootp,
+	   "boot image via network using BOOTP/TFTP protocol",
+	   "[loadAddress] [[hostIPaddr:]bootfilename]");
diff --git a/include/net-lwip.h b/include/net-lwip.h
index 7819f9823a4..9edfb6e5f37 100644
--- a/include/net-lwip.h
+++ b/include/net-lwip.h
@@ -90,6 +90,7 @@ int net_lwip_dns_resolve(char *name_or_ip, ip_addr_t *ip);
  */
 bool wget_validate_uri(char *uri);
 
+int do_bootp(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
 int do_dns(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
 int do_nfs(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
 int do_tftpsrv(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
diff --git a/lib/lwip/u-boot/lwipopts.h b/lib/lwip/u-boot/lwipopts.h
index 217ce6f7977..91a18a049da 100644
--- a/lib/lwip/u-boot/lwipopts.h
+++ b/lib/lwip/u-boot/lwipopts.h
@@ -127,8 +127,18 @@
 
 #define LWIP_DHCP_DOES_ACD_CHECK	0
 
+#ifdef CONFIG_CMD_BOOTP
+/*
+ * Receive unicast replies before the client has an IP address, also when
+ * the DHCP state machine is not built. The port is in network byte order.
+ */
+#define LWIP_IP_ACCEPT_UDP_PORT(port) ((port) == PP_HTONS(68))
+#endif
+
+#if defined(CONFIG_CMD_BOOTP) || defined(CONFIG_CMD_DHCP)
 #ifdef CONFIG_CMD_DHCP
 #define LWIP_HOOK_FILENAME "lwip-dhcp.h"
+#endif
 /* Core/PXE options plus two maximum-length hostname/vendor-class options. */
 #define DHCP_OPTIONS_LEN		640
 /* Stage NTP after concatenating fragments, not in the core option parser. */
@@ -189,7 +199,7 @@
 	UBOOT_DHCP_DNS UBOOT_DHCP_NTP UBOOT_DHCP_HOSTNAME \
 	UBOOT_DHCP_FILESIZE UBOOT_DHCP_ROOTPATH UBOOT_DHCP_DOMAIN \
 	UBOOT_DHCP_TIMEOFFSET UBOOT_DHCP_PXE_CONFIG 67
-#endif /* CONFIG_CMD_DHCP */
+#endif /* defined(CONFIG_CMD_BOOTP) || defined(CONFIG_CMD_DHCP) */
 
 #define LWIP_AUTOIP                     0
 
diff --git a/net/lwip/Makefile b/net/lwip/Makefile
index 5291cbb2a1c..b017c32629c 100644
--- a/net/lwip/Makefile
+++ b/net/lwip/Makefile
@@ -1,7 +1,9 @@
 ccflags-y += -I$(srctree)/lib/lwip/lwip/src/include -I$(srctree)/lib/lwip/u-boot
 
 obj-$(CONFIG_$(PHASE_)DM_ETH) += net-lwip.o
-obj-$(CONFIG_CMD_DHCP) += dhcp.o
+ifneq ($(filter y,$(CONFIG_CMD_BOOTP) $(CONFIG_CMD_DHCP)),)
+obj-y += dhcp.o
+endif
 obj-$(CONFIG_DNS) += dns.o
 obj-$(CONFIG_LWIP_ICMP_SHOW_UNREACH) += icmp_unreach.o
 obj-$(CONFIG_CMD_NFS) += nfs.o
diff --git a/net/lwip/dhcp.c b/net/lwip/dhcp.c
index 3486a94084b..eed697efd87 100644
--- a/net/lwip/dhcp.c
+++ b/net/lwip/dhcp.c
@@ -20,10 +20,13 @@
 #include <lwip/dhcp.h>
 #include <lwip/dns.h>
 #include <lwip/prot/dhcp.h>
+#include <lwip/udp.h>
 #include <u-boot/uuid.h>
 
 #define DHCP_TIMEOUT_MS ((3ULL + 5ULL * CONFIG_NET_RETRY_COUNT) * 1000)
-#define DHCP_RETRANSMIT_MAX_MS (U16_MAX * DHCP_FINE_TIMER_MSECS)
+/* Keep shared retry settings representable by DHCP's u16, 500 ms timer. */
+#define DHCP_RETRANSMIT_MAX_MS (U16_MAX * 500U)
+#define BOOTP_MIN_LEN (DHCP_MSG_LEN + 64)
 
 struct bootp_config {
 	ip4_addr_t ip;
@@ -64,6 +67,8 @@ struct dhcp_efi_cache {
 struct dhcp_options {
 	struct netif *netif;
 	struct bootp_config config;
+	u32 bootp_xid;
+	bool bootp_bound;
 	ulong start;
 	ulong timeout;
 	u32 retransmit_init;
@@ -87,7 +92,7 @@ struct dhcp_options {
 	struct dhcp_efi_cache efi[];
 };
 
-/* The address-less runtime attachment excludes a second DHCP command. */
+/* The address-less runtime attachment excludes another BOOTP/DHCP command. */
 static struct dhcp_options *active_options;
 
 /*
@@ -156,7 +161,7 @@ static int dhcp_timing_options(struct dhcp_options *options)
 		if ((value && dhcp_parse_number(value, 10,
 						i ? DHCP_RETRANSMIT_MAX_MS : ULONG_MAX,
 						&values[i])) || (i && !values[i])) {
-			log_err("Invalid DHCP timing setting: %s\n", names[i]);
+			log_err("Invalid BOOTP/DHCP timing setting: %s\n", names[i]);
 			return -EINVAL;
 		}
 	}
@@ -212,10 +217,11 @@ static int dhcp_boot_options(struct pbuf *p, unsigned int pos, unsigned int end,
 				return -EINVAL;
 			/*
 			 * RFC 3396: concatenate fragments before interpreting them.
-			 * For the NTP list retain only the first address, but validate
-			 * the length of the entire list below.
+			 * Retain only the requested addresses from server/router lists,
+			 * but validate the length of the entire list below.
 			 */
 			if (code != DHCP_OPTION_NTP && code != DHCP_OPTION_DNS_SERVER &&
+			    code != DHCP_OPTION_ROUTER &&
 			    len > opt->size - opt->len)
 				return -E2BIG;
 			copy = min_t(size_t, len, opt->size - min(opt->len, opt->size));
@@ -327,6 +333,8 @@ static err_t dhcp_parse_boot_data(struct pbuf *p, struct dhcp_boot_data *data,
 	return ERR_OK;
 }
 
+/* lwip/dhcp.h exposes the DHCP state and API only with LWIP_DHCP. */
+#if LWIP_DHCP
 err_t net_lwip_dhcp_offer(struct netif *netif, struct dhcp *dhcp, struct pbuf *p)
 {
 	struct dhcp_options *options = active_options;
@@ -446,6 +454,8 @@ err_t net_lwip_dhcp_ack(struct netif *netif, struct dhcp *dhcp, struct pbuf *p)
 	return ERR_OK;
 }
 
+#endif /* LWIP_DHCP */
+
 static void dhcp_append(struct dhcp_options *options, struct dhcp_msg *msg,
 			u16_t *len, u8 code, const void *data, size_t size)
 {
@@ -462,6 +472,7 @@ static void dhcp_append(struct dhcp_options *options, struct dhcp_msg *msg,
 	*len += size;
 }
 
+#if LWIP_DHCP
 void net_lwip_dhcp_append(struct netif *netif, struct dhcp *dhcp, u8_t state,
 			  struct dhcp_msg *msg, u8_t type, u16_t *len)
 {
@@ -495,6 +506,7 @@ void net_lwip_dhcp_append(struct netif *netif, struct dhcp *dhcp, u8_t state,
 	if (options->have_uuid)
 		dhcp_append(options, msg, len, 97, options->uuid, sizeof(options->uuid));
 }
+#endif /* LWIP_DHCP */
 
 static int dhcp_pxe_options(struct dhcp_options *options)
 {
@@ -587,7 +599,9 @@ static int dhcp_server_env(struct dhcp_options *options)
 		return env_set("serverip", ip4addr_ntoa(&options->proxy_server)) ||
 			env_set("tftpserverip", ip4addr_ntoa(&options->proxy_server));
 
-	return env_set("serverip", ip4addr_ntoa(&config->server)) ||
+	/* A BOOTP reply may omit siaddr. Keep the configured server in that case. */
+	return (!ip4_addr_isany(&config->server) &&
+		env_set("serverip", ip4addr_ntoa(&config->server))) ||
 		env_set("tftpserverip", ip4_addr_isany(&config->next_server) ?
 			NULL : ip4addr_ntoa(&config->next_server));
 }
@@ -624,6 +638,7 @@ static int bootp_store_config(struct net_lwip_ctx *net, bool explicit_file,
 	return dhcp_boot_env(&options->reply);
 }
 
+#if LWIP_DHCP
 static int dhcp_loop(struct net_lwip_ctx *net, bool explicit_file,
 		     struct dhcp_options *options)
 {
@@ -632,13 +647,6 @@ static int dhcp_loop(struct net_lwip_ctx *net, bool explicit_file,
 	unsigned long proxy_start = 0;
 	struct dhcp *dhcp;
 	bool bound = false;
-	int idx;
-
-	idx = dev_seq(net->dev);
-	if (idx < 0 || idx > 99) {
-		log_err("unexpected idx %d\n", idx);
-		return CMD_RET_FAILURE;
-	}
 
 	start = get_timer(0);
 	options->start = start;
@@ -728,6 +736,199 @@ static void dhcp_retire(struct net_lwip_ctx *net)
 		dhcp_release_and_stop(net->netif);
 	dhcp_cleanup(net->netif);
 }
+#else
+static inline int dhcp_loop(struct net_lwip_ctx *net, bool explicit_file,
+			    struct dhcp_options *options)
+{
+	return CMD_RET_FAILURE;
+}
+
+static inline void dhcp_retire(struct net_lwip_ctx *net)
+{
+}
+#endif /* LWIP_DHCP */
+
+static void bootp_recv(void *arg, struct udp_pcb *pcb, struct pbuf *p,
+		       const ip_addr_t *addr, u16_t port)
+{
+	struct dhcp_options *options = arg;
+	struct netif *netif = options->netif;
+	struct dhcp_boot_data *data = &options->candidate;
+	struct bootp_config config = {};
+	struct dhcp_msg msg;
+	u8 type, overload = 0;
+	struct dhcp_boot_option opts[] = {
+		{ 1, true, false, &config.netmask, sizeof(config.netmask) },
+		{ 3, true, false, &config.gateway, sizeof(config.gateway) },
+		{ 53, true, false, &type, sizeof(type) },
+	};
+	int ret;
+
+	if (options->bootp_bound || port != 67 || !IP_IS_V4(addr) ||
+	    p->tot_len < BOOTP_MIN_LEN ||
+	    pbuf_copy_partial(p, &msg, DHCP_OPTIONS_OFS, 0) != DHCP_OPTIONS_OFS ||
+	    msg.op != DHCP_BOOTREPLY || msg.htype != 1 ||
+	    msg.hlen != netif->hwaddr_len || msg.hlen > sizeof(msg.chaddr) ||
+	    memcmp(msg.chaddr, netif->hwaddr, msg.hlen) ||
+	    ntohl(msg.xid) != options->bootp_xid)
+		goto out;
+	memcpy(&config.ip, &msg.yiaddr, sizeof(config.ip));
+	if (ip4_addr_isany(&config.ip) || ip4_addr_ismulticast(&config.ip) ||
+	    ip4_addr_get_u32(&config.ip) == IPADDR_BROADCAST)
+		goto out;
+	memcpy(&config.server, &msg.siaddr, sizeof(config.server));
+	config.next_server = config.server;
+	memset(data, 0, sizeof(*data));
+	if (ntohl(msg.cookie) == DHCP_MAGIC_COOKIE) {
+		if (dhcp_parse_boot_data(p, data, false))
+			goto out;
+		ret = dhcp_boot_options(p, DHCP_OPTIONS_OFS, p->tot_len,
+					opts, ARRAY_SIZE(opts), &overload);
+		if (!ret && (overload & DHCP_OVERLOAD_FILE))
+			ret = dhcp_boot_options(p, DHCP_FILE_OFS, DHCP_FILE_OFS + DHCP_FILE_LEN,
+						opts, ARRAY_SIZE(opts), NULL);
+		if (!ret && (overload & DHCP_OVERLOAD_SNAME))
+			ret = dhcp_boot_options(p, DHCP_SNAME_OFS, DHCP_SNAME_OFS + DHCP_SNAME_LEN,
+						opts, ARRAY_SIZE(opts), NULL);
+		/*
+		 * A DHCP offer/ACK is not a BOOTP assignment. In particular, never
+		 * use an offer without completing the DHCP request/ACK exchange.
+		 */
+		if (ret || opts[2].len ||
+		    (opts[0].len && opts[0].len != sizeof(config.netmask)) ||
+		    opts[1].len % sizeof(config.gateway))
+			goto out;
+		config.have_netmask = opts[0].len != 0;
+		config.have_gateway = opts[1].len != 0;
+	} else {
+		/* RFC 951 permits a vendor area without RFC 1048 extensions. */
+		memcpy(data->bootfile, msg.file, DHCP_FILE_LEN);
+		data->bootfile[DHCP_FILE_LEN] = 0;
+	}
+	options->reply = *data;
+	options->config = config;
+	options->bootp_bound = true;
+out:
+	pbuf_free(p);
+}
+
+static int bootp_send(struct udp_pcb *pcb, struct dhcp_options *options)
+{
+	static const u8 zeros[32];
+	const struct {
+		u8 code;
+		u8 len;
+		bool enabled;
+	} requests[] = {
+		{ 1, 4, IS_ENABLED(CONFIG_BOOTP_SUBNETMASK) },
+		{ 3, 4, IS_ENABLED(CONFIG_BOOTP_GATEWAY) },
+		{ 6, 4, IS_ENABLED(CONFIG_BOOTP_DNS) },
+		{ 12, 32, IS_ENABLED(CONFIG_BOOTP_HOSTNAME) && !options->hostname[0] },
+		{ 13, 2, IS_ENABLED(CONFIG_BOOTP_BOOTFILESIZE) },
+		{ 17, 32, IS_ENABLED(CONFIG_BOOTP_BOOTPATH) },
+		{ 40, 32, IS_ENABLED(CONFIG_BOOTP_NISDOMAIN) },
+		{ 42, 4, IS_ENABLED(CONFIG_BOOTP_NTPSERVER) },
+		{ 2, 4, IS_ENABLED(CONFIG_BOOTP_TIMEOFFSET) },
+	};
+	struct dhcp_msg *msg;
+	struct pbuf *p;
+	u16 len = 0;
+	unsigned int i;
+	int ret = -EINVAL;
+
+	p = pbuf_alloc(PBUF_TRANSPORT, sizeof(*msg), PBUF_RAM);
+	if (!p)
+		return -ENOMEM;
+	msg = p->payload;
+	memset(msg, 0, sizeof(*msg));
+	msg->op = DHCP_BOOTREQUEST;
+	msg->htype = 1;
+	msg->hlen = options->netif->hwaddr_len;
+	msg->xid = htonl(options->bootp_xid);
+	msg->secs = htons(min_t(ulong, get_timer(options->start) / 1000, U16_MAX));
+	memcpy(msg->chaddr, options->netif->hwaddr, msg->hlen);
+	copy_filename((char *)msg->file, net_boot_file_name, sizeof(msg->file));
+	msg->cookie = htonl(DHCP_MAGIC_COOKIE);
+	dhcp_append(options, msg, &len, 60, options->vendor, strlen(options->vendor));
+	dhcp_append(options, msg, &len, 12, options->hostname, strlen(options->hostname));
+	/*
+	 * BOOTP uses zero-filled RFC 1048 tags, not a DHCP parameter request
+	 * list. There is deliberately no DHCP message type or lease request.
+	 */
+	for (i = 0; i < ARRAY_SIZE(requests); i++)
+		if (requests[i].enabled)
+			dhcp_append(options, msg, &len, requests[i].code, zeros, requests[i].len);
+	if (options->append_failed)
+		goto out;
+	msg->options[len++] = DHCP_OPTION_END;
+	pbuf_realloc(p, max_t(u16, BOOTP_MIN_LEN, DHCP_OPTIONS_OFS + len));
+	ret = udp_sendto_if_src(pcb, p, IP_ADDR_BROADCAST, 67,
+				options->netif, IP4_ADDR_ANY);
+out:
+	pbuf_free(p);
+
+	return ret;
+}
+
+static int bootp_loop(struct net_lwip_ctx *net, bool explicit_file,
+		      struct dhcp_options *options)
+{
+	struct udp_pcb *pcb;
+	ulong sent, timeout;
+	u8 tries = 1;
+	int ret;
+
+	pcb = udp_new_ip_type(IPADDR_TYPE_V4);
+	if (!pcb)
+		return -ENOMEM;
+	ip_set_option(pcb, SOF_BROADCAST);
+	udp_bind_netif(pcb, net->netif);
+	ret = udp_bind(pcb, IP4_ADDR_ANY, 68);
+	if (ret)
+		goto out;
+	udp_recv(pcb, bootp_recv, options);
+	options->bootp_xid = rand();
+	options->bootp_bound = false;
+	options->start = get_timer(0);
+	sent = options->start;
+	timeout = bootp_timeout(options, tries);
+	ret = bootp_send(pcb, options);
+	while (!ret) {
+		ret = net_lwip_poll();
+		if (ret < 0)
+			break;
+		if (ctrlc()) {
+			printf("Abort\n");
+			ret = -EINTR;
+			break;
+		}
+		if (options->bootp_bound) {
+			ret = bootp_store_config(net, explicit_file, options);
+			if (!ret)
+				printf("BOOTP bound to address %pI4 (%lu ms)\n",
+				       &options->config.ip, get_timer(options->start));
+			break;
+		}
+		if (get_timer(options->start) >= options->timeout) {
+			ret = -ETIMEDOUT;
+			break;
+		}
+		ret = 0;
+		if (get_timer(sent) >= timeout) {
+			ret = bootp_send(pcb, options);
+			sent = get_timer(0);
+			if (tries < U8_MAX)
+				tries++;
+			timeout = bootp_timeout(options, tries);
+		}
+		mdelay(1);
+	}
+out:
+	/* Remove the receive callback before retry, handoff or stack release. */
+	udp_remove(pcb);
+
+	return ret;
+}
 
 static int dhcp_nfs_autoload(struct cmd_tbl *cmdtp, int flag, int argc,
 			     char *const argv[])
@@ -751,7 +952,8 @@ static int dhcp_nfs_autoload(struct cmd_tbl *cmdtp, int flag, int argc,
 	return ret;
 }
 
-int do_dhcp(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
+static int bootp_run(struct cmd_tbl *cmdtp, int flag, int argc,
+		     char *const argv[], bool bootp)
 {
 	struct net_lwip_ctx net = {};
 	struct dhcp_options *options;
@@ -784,7 +986,7 @@ int do_dhcp(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 	hostname = IS_ENABLED(CONFIG_BOOTP_SEND_HOSTNAME) ? env_get("hostname") : NULL;
 	vendor = env_get("bootp_vci") ?: CONFIG_BOOTP_VCI_STRING;
 	if ((hostname && strlen(hostname) > 255) || strlen(vendor) > 255) {
-		log_err("DHCP hostname/vendor class exceeds 255 bytes\n");
+		log_err("BOOTP/DHCP hostname/vendor class exceeds 255 bytes\n");
 		return CMD_RET_FAILURE;
 	}
 	options = calloc(1, sizeof(*options) +
@@ -793,7 +995,10 @@ int do_dhcp(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 		return CMD_RET_FAILURE;
 	strlcpy(options->hostname, hostname ?: "", sizeof(options->hostname));
 	strlcpy(options->vendor, vendor, sizeof(options->vendor));
-	if (dhcp_pxe_options(options) || dhcp_timing_options(options)) {
+	ret = dhcp_timing_options(options);
+	if (IS_ENABLED(CONFIG_CMD_DHCP) && !ret && !bootp)
+		ret = dhcp_pxe_options(options);
+	if (ret) {
 		free(options);
 		return CMD_RET_FAILURE;
 	}
@@ -806,6 +1011,10 @@ int do_dhcp(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 	active_options = options;
 
 	for (;;) {
+		if (dev_seq(net.dev) < 0 || dev_seq(net.dev) > 99 || net.netif->hwaddr_len != 6) {
+			ret = CMD_RET_FAILURE;
+			break;
+		}
 		options->netif = net.netif;
 		options->have_offer = false;
 		options->have_proxy = false;
@@ -814,10 +1023,15 @@ int do_dhcp(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 			options->efi->ack_len = 0;
 			options->efi->proxy_len = 0;
 		}
-		ret = dhcp_loop(&net, !!filename, options);
+		ret = CMD_RET_FAILURE;
+		if (IS_ENABLED(CONFIG_CMD_BOOTP) && bootp)
+			ret = bootp_loop(&net, !!filename, options);
+		if (IS_ENABLED(CONFIG_CMD_DHCP) && !bootp)
+			ret = dhcp_loop(&net, !!filename, options);
 		if (ret != -ETIMEDOUT)
 			break;
-		dhcp_retire(&net);
+		if (IS_ENABLED(CONFIG_CMD_DHCP) && !bootp)
+			dhcp_retire(&net);
 		if (IS_ENABLED(CONFIG_BOOTP_MAY_FAIL) &&
 		    (env_get_yesno("ethrotate") == 0 || net_restart_wrap))
 			break;
@@ -829,10 +1043,12 @@ int do_dhcp(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 		}
 	}
 	/*
-	 * A download needs strict addressing, incompatible with DHCP's
-	 * address-less runtime attachment. Retire DHCP before handing off.
+	 * A download needs strict addressing, incompatible with the
+	 * address-less runtime attachment. Retire DHCP before handing off;
+	 * the BOOTP loop has already removed its receive callback.
 	 */
-	dhcp_retire(&net);
+	if (IS_ENABLED(CONFIG_CMD_DHCP) && !bootp)
+		dhcp_retire(&net);
 	active_options = NULL;
 	free(options);
 	net_lwip_stop(&net);
@@ -854,3 +1070,13 @@ int do_dhcp(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 
 	return CMD_RET_FAILURE;
 }
+
+int do_dhcp(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
+{
+	return bootp_run(cmdtp, flag, argc, argv, false);
+}
+
+int do_bootp(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
+{
+	return bootp_run(cmdtp, flag, argc, argv, true);
+}

-- 
2.53.0

