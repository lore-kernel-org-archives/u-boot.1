Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56290CA9EC7
	for <u-boot@archiver.kernel.org>; Sun, 11 Oct 2026 00:38:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1C12E60A39;
	Sun, 11 Oct 2026 00:38:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GND_p7XME5N6; Sun, 11 Oct 2026 00:37:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D335D60A4F
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791679076;
	b=JEd6acMa913P7asHw7RKmOQEi+zG2g82kFkSy+5byov5i2hfnuPwEtqNwNQ5x0L8pWTT
	 ZG/A0G+pNosymJAnNIIRsHg/ONbWOV8HC2hR5buRwELbTzFRTpk3QLlPTsp7QJWyHHUYb
	 RpxKERSjlU5OG4B2gSgZvIxRrw19KClrnyJiTFMQB8SanvSFNVUxw0UxsQ53zH//kPu/f
	 FjLYmmRiIwOROk78eWlXsdxmIFQQ8E6KyM833deML0v79Rta7q7/L+L3VQgRUC7NXcGW9
	 /6tBtVozUDjDoFHlmGwIiYjxeTnO9/0YHjiM31bCmRM1ZojUjonAOYWKUzUHxWKGOdg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791679076;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=pp3R4pXwq6ZZVbaDqHtT31OTeuOyu+patiJOEWCkMA0=;
	b=TYfqj3RMSpm5RlHQd6kTZIKkelU7RUxtjOXi4sn7L0mjfMyXMyqurxLv74lNkSRHTGHV
	 6D7uc5g5dt66CQ6q0j1y9ULp0IwRr4T76Uhd0eCgG7coHkVIal3B6m1IPsSWO5s3Rtwhx
	 afgYh3vSFwE4OVKFGNFf6f24210WeoG7RjVx11J1NjmnnVEfepX/5BvjPxhh5WEdKkvms
	 BTtfaXJkMjumXhhjDKSPZBQ28wHJ+WdiOHVYk+a5SpQDT3kZ2EB79wlRYj04WGPSkYAIg
	 w4LKE6aqqpzlxUGyIO1HzzyMwMnJwqWcS4YaBqhLr7TzGB/xbXpuPF6qpdqT4r3216g==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=DYyNIycQ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791679076;
	bh=pp3R4pXwq6ZZVbaDqHtT31OTeuOyu+patiJOEWCkMA0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=g6Il4ObC5jO3sYMPrqlvAGR00DcnOHnU5jW07bCFP+Q+RmjqIPihupIA2dsSVYjGT
	 lYLTRyyaHubzrxQ5gfIZZiM51NTrfNttm6iVVQn3oh2m0YkaQhVduDd8wqVNf9qdxD
	 pX2I6wwlAWTH8uG/u3QOBYGDvKrYTzXrwuFnHHozdiBTtS4BOtZ/leO2h/lbfuAN1/
	 uF2/NcRL7LH5yeHY6/Mm61S2miDxhwXqsE5OrqSu5F/fIK2frmvOyMPEF4f5kfn4Y7
	 GDkvqE6K4IMtRbkkPDeTPk/8cJccXupk40xC/43/KhT2FTIE5OpjR14rzqYILSeh04
	 5ixE8O4lPWwag==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D335D60A4F;
	Sun, 11 Oct 2026 00:37:55 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id B7D40105
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 00:37:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A118F608FB
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 00:37:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TbhGHoBQfiJ4 for <u-boot@lists.u-boot-project.org>;
 Sun, 11 Oct 2026 00:37:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 2238C6060B
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2001:4860:4864:20::30"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791679060;
 b=Q5tPY8EL7l6yr2gS3nsYjXTaU8/hXh12tvnw2/LWXSlEkG6a1FCRA4HDiVvM321t+67a
 8M/Pc+t0konRi6RP9LHpNZkSdBSHLYdV+0ELy/EHjoyrkip8iTwyaYQmHqUK5VtOEPK8k
 9fuog89TJI0RMpSvc+3IE6Yl1/r4GE5JaeePqT7Nyi34GEUny54DFmQPztbsvKiqn/OL8
 TJT6mO3ohN5Ud3lNt/I4A0PEibdAKDgmSuWccmhJDZYYMt+TuiCJW4wU1n+SWgjIkMZwp
 3PyXbsG1utBR0wF06SVCry5XAPGOnwMQx9E1tdkw6YYgD0glFB/lVmoUcRnkYQX3QdQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791679060;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer;
 bh=pp3R4pXwq6ZZVbaDqHtT31OTeuOyu+patiJOEWCkMA0=;
 b=XlxIY02IUGucpDH0dEO/LzZropZ5dWVzKxqIXcWVHHlk6RufTfxBlAljQrXH/XJdsc6f
 phcdbalR5RokUKr7rhbaAcyPGXCbxXSEXWLsakbUnKFbpjcEoirPz9EF2aG93O5Xt17Bm
 3y4JO1r5n/BaQokaZopcA/6fRtAjQcS9EKtMeotVh4SX1UbRzzMadpsygyoj61aJrqMfl
 X3sVoDJz57uWmgwjIkqRpYkOQzbuIyHlpXLeOSDp0cWYAZ26lG8RRWJ2dbgPQpLPE+sgb
 UmbzrHzNXT6JAjhcB39CPy29IsHLosdpP1kBv6s3K1gvNXYxySacqcjGnWnfOrHT42w==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=DYyNIycQ; 
 arc=none smtp.remote-ip="2001:4860:4864:20::30"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::30; helo=mail-oa1-x30.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=DYyNIycQ
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com
 [IPv6:2001:4860:4864:20::30])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2238C6060B
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 00:37:39 +0000 (UTC)
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-49dfaa16190so2093568fac.1
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 17:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791679059; x=1792283859;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pp3R4pXwq6ZZVbaDqHtT31OTeuOyu+patiJOEWCkMA0=;
 b=DYyNIycQyHvK+IIcyUZPQsjjADaEz7Da01TOG3lqkuQl0XrbQ8ZypkagWIHb+eymxC
 wC1ayEdXOgoTFygfscexv6XPBtPahdPivIVbOXwmEVazgHbbGDqwZXLR/TKcpOPCpMSn
 BiOdutPSEvJhU5mPElgSJAWpZV5ZL7tnoJVOQmkUw9JurV2UkUXJGEw2vlgTfOTQ2fWI
 /sdvoDxNUGkBUH7GjyVF9IXZ/TMh5Y2EoB8GGH3g19qemGOR8XoexPZs0sKO0TbcGd2u
 Adh3OjOpuKjlyJ/sqgM8fAnx31++dKwYDtleBH6EnNBG3BwqGhxk6vBbuzqSU9l0Z24f
 Fakg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791679059; x=1792283859;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pp3R4pXwq6ZZVbaDqHtT31OTeuOyu+patiJOEWCkMA0=;
 b=WjB+AhcZ/pV5lbsMEnFl+ngT3sO6OJjv0DtADpfJYUFbe3eAT7S2ruGkW+O9iJkHpS
 l68oasK0bCqefYgUH0Ui309Ux7ko4M0Ogo7Hn/MXJoz2BiWxoqYmBoTNEaHai098YWkM
 Bfrl/nzpb008kF9FLRVAu1FYMF5bWZwku9IQz4NYWYGdFngzNOxoLoEHuRVa9JB+sfF0
 PLHhZSIhO9snU79uHni+xWD5yt9LNkfd90kJSf63ChhWB2IgjH8EwbRKEx72WV+dfYnb
 9JlpCpsVCbAZHGQXtFz0FWYCDvYovp8caIDxVU6ZNJeKJSQXowrAg+Ay29utv65aZmjK
 nuYA==
X-Gm-Message-State: AFq9FYJEpxs0QmerHzhXF2YgPW8nso5YTguVdJ7fhUnWhxv/zZOlVGyK
 sumCNa30ZY8w7Q3xTrHSq/aJO838Worarn9zCe9ugV2C0LrECS6IsgPW
X-Gm-Gg: AYBFou1QSY6jvrZ212FA1irY92tMq29nmB93Jbce3np6j1o9jSLgGdLeTto79V8i4rt
 97KyyKYEE2YH12G95HDCJh9hbGdvNitnMjxAHAhW9VQm4is5D1lYkEuFyipqL+1M8BH8OV57M9g
 6SC8rlm+l8HEXr4lYjdIW9Gx6Yw0ryQZckv3ny5ylreMeNddknWs7DNa82Hh1AVFgzw2349/VhX
 n5kV77D5UCeVGAFVR9C0tx2s7oYHj7UKIXkaVF3Mo/QRmJqoYm5B9Nh0m8T22Pq1a60g0MpTJXi
 FYCOJBXF0FMgczHbNbpGhRN+iNiZEiLW0kKlB0G37wRL3+jb4Pa4qjGeMQ/wWenl7GgJ8dMrCh/
 Jq/E8mD6heuw9b0w5lrmYGmYX01yVFC9jMafgOoUMYkPOEjd7OvJBslHL9heW3nUbTHjgiqq9DQ
 OAGDqdoDISUQv0wZqBKxn01g0s038E4fmSi0oDnXCXY6KjfXs4PnlLQX1U9eASnh43JHWlm7IVg
 xDePFlI665m9eb3lZ1NkgWaTIhrTqNRCFFmMSAFbFG7xQa8DBrw3C6L20MIp6HCBV8mtlm9XyE3
 a0P/vW5ujTP4WnHj1lZaAJQd33+ikd77sN/Y2112X5g/cQtRyi4JyVvcxQPwJovBoGpdNJAd3ec
 D48YcKSH/nNypVz2uz531/gQ08NAvYkg=
X-Received: by 2002:a05:6870:17a0:b0:49e:50bc:79dc with SMTP id
 586e51a60fabf-4a2a8a7a7b9mr4398556fac.22.1791679058827; 
 Sat, 10 Oct 2026 17:37:38 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4a2a84a1457sm5386985fac.4.2026.10.10.17.37.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Oct 2026 17:37:38 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sat, 10 Oct 2026 18:37:05 -0600
Subject: [PATCH 10/16] net: lwip: honor autostart after TFTP download commands
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261010-submit-lwip-tftp-combined-v1-v1-10-cf8002c6f401@gmail.com>
References: <20261010-submit-lwip-tftp-combined-v1-v1-0-cf8002c6f401@gmail.com>
In-Reply-To: <20261010-submit-lwip-tftp-combined-v1-v1-0-cf8002c6f401@gmail.com>
To: Jerome Forissier <jerome.forissier@arm.com>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Johan Jonker <jbx6244@gmail.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 David Lechner <dlechner@baylibre.com>, Lukasz Majewski <lukma@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Igor Opaniuk <igor.opaniuk@gmail.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Peter Robinson <pbrobinson@gmail.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Weijie Gao <weijie.gao@mediatek.com>, Pranav Sanwal <pranav.sanwal@amd.com>, 
 Alexey Charkov <alchark@flipper.net>, 
 Vladimir Oltean <vladimir.oltean@nxp.com>, 
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

Match the legacy tftpboot and tftpsrv commands by checking autostart after
a successful nonempty download. Run the boot hook only after the TFTP
callbacks and shared runtime attachment are removed, and propagate its
result. Internal callers use the download-only helpers; tftpput never
boots its source buffer.

Exercise receive-server autostart, empty files and metadata failures in
sandbox without handing off to a bootable image.

Also deliver a second WRQ and DATA in the final receive batch. A completed,
empty or failed command must retain its original result and leave the
image and published metadata untouched by the later transfer.

Exercise command and helper downloads with autostart enabled. Check that
internal TFTP and DHCP callers return downloaded data without booting
it, restore the exact environment value, and preserve errors. A direct
TFTP command must attempt to boot the same non-bootable bytes after
releasing the network runtime and propagate the boot failure.

Check that a stale DHCP filename does not override a later command's
bootfile setting or its IP-derived default, with either network stack.

Preserve colon-containing filenames and lwIP's numeric destination-port
extension. Inspect requested block and window sizes, including overrides
above the default, upload MTU limits, and builds with NET_TFTP_VARS
disabled. Keep client-specific override tests conditional on that option.

Cover read-only autostart settings and the protocol-default 512-byte
block size, which does not require a blksize wire option.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 cmd/Kconfig               |   5 +-
 doc/usage/cmd/tftpsrv.rst |   9 +-
 net/lwip/tftp.c           |  12 +-
 test/dm/lwip_dhcp.c       |   8 ++
 test/dm/lwip_net_loop.c   |   3 +-
 test/dm/lwip_tftp.c       | 109 ++++++++++++++---
 test/dm/tftp.c            | 303 +++++++++++++++++++++++++++++++++++++++++++---
 7 files changed, 404 insertions(+), 45 deletions(-)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 465f84976a9..b003d07e0e6 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -2310,8 +2310,9 @@ config CMD_TFTPSRV
 	depends on CMD_TFTPBOOT
 	help
 	  Act as a TFTP server and receive the first incoming file into
-	  memory. The command returns successfully after the transfer so
-	  boot scripts can boot the received image from the load address.
+	  memory. If autostart is enabled, boot the received image after a
+	  successful nonempty transfer. Otherwise return to the caller so
+	  boot scripts can use the image at the load address.
 
 config CMD_WGET
 	bool "wget"
diff --git a/doc/usage/cmd/tftpsrv.rst b/doc/usage/cmd/tftpsrv.rst
index d067afdba57..2c6d08cdc80 100644
--- a/doc/usage/cmd/tftpsrv.rst
+++ b/doc/usage/cmd/tftpsrv.rst
@@ -25,10 +25,10 @@ loadAddress
     image load address.
 
 After a successful transfer, the *fileaddr* and *filesize* environment
-variables describe the received file. The command returns successfully after
-the transfer has completed. It does not boot the file automatically; boot
-scripts can use commands such as bootm, booti or bootefi to boot from the
-load address.
+variables describe the received file. If *autostart* is enabled, a nonempty
+file is passed to bootm after the transfer completes. Otherwise, the command
+returns without booting the file; boot scripts can use commands such as
+bootm, booti or bootefi to boot from the load address.
 
 The transfer is aborted if no transfer has started after about 50 seconds or
 if Ctrl-C is pressed.
@@ -45,6 +45,7 @@ In the example the following steps are executed:
 ::
 
     => setenv autoload no
+    => setenv autostart no
     => dhcp
     BOOTP broadcast 1
     DHCP client bound to address 192.168.1.40 (7 ms)
diff --git a/net/lwip/tftp.c b/net/lwip/tftp.c
index 4cf451e1184..f29a20f518e 100644
--- a/net/lwip/tftp.c
+++ b/net/lwip/tftp.c
@@ -581,7 +581,9 @@ int do_tftpsrv(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 
 out:
 	net_lwip_stop(&net);
-	return ret;
+	if (ret || !net_boot_file_size)
+		return ret;
+	return bootm_maybe_autostart(cmdtp, argv[0]);
 }
 
 static int tftp_default_filename(char *fname, size_t size)
@@ -807,7 +809,13 @@ out:
 
 int do_tftpb(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 {
-	return do_tftp(cmdtp, flag, argc, argv, TFTP_DOWNLOAD);
+	int ret;
+
+	ret = do_tftp(cmdtp, flag, argc, argv, TFTP_DOWNLOAD);
+	if (ret || !net_boot_file_size)
+		return ret;
+	/* The transfer's callbacks and runtime attachment are already gone. */
+	return bootm_maybe_autostart(cmdtp, argv[0]);
 }
 
 int do_tftpput(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
diff --git a/test/dm/lwip_dhcp.c b/test/dm/lwip_dhcp.c
index 7144a32dd17..57e1ffdba10 100644
--- a/test/dm/lwip_dhcp.c
+++ b/test/dm/lwip_dhcp.c
@@ -265,10 +265,18 @@ static int dhcp_handoff_check(struct unit_test_state *uts,
 	}
 	*test = (struct dhcp_handoff_test){ .offer = "offered.bin", .fail = true };
 	ut_assertok(env_set("autoload", "NFS"));
+	ut_assertok(env_set("autostart", "yes-please"));
 	ut_asserteq(-ENOENT, dhcp_run(0x2000000, "explicit.bin", true));
 	ut_asserteq_str("NFS", env_get("autoload"));
 	ut_assert(!test->dhcp_alive);
 	ut_assertnull(netif_default);
+	*test = (struct dhcp_handoff_test){ .offer = "offered.bin" };
+	if (IS_ENABLED(CONFIG_CMD_TFTPBOOT)) {
+		ut_assertok(dhcp_run(0x2000000, "explicit.bin", true));
+		ut_asserteq_str("yes-please", env_get("autostart"));
+		ut_asserteq_str("NFS", env_get("autoload"));
+		ut_assertnull(netif_default);
+	}
 	*test = (struct dhcp_handoff_test){ .offer = "", .timeout = true };
 	ut_asserteq(-ENOENT, dhcp_run(0x2000000, NULL, true));
 	ut_asserteq(0, test->tftp);
diff --git a/test/dm/lwip_net_loop.c b/test/dm/lwip_net_loop.c
index 2e646e40020..4fedc9ba9e4 100644
--- a/test/dm/lwip_net_loop.c
+++ b/test/dm/lwip_net_loop.c
@@ -71,13 +71,14 @@ static int net_loop_check(struct unit_test_state *uts, int *mode)
 	ut_assertok(env_set("tftpdstp", NULL));
 	ut_assertok(env_set("loadaddr", "2000000"));
 	ut_assertok(env_set("bootfile", "other.bin"));
-	ut_assertok(env_set("autostart", "no"));
+	ut_assertok(env_set("autostart", "yes"));
 	strcpy(net_boot_file_name, "test.bin");
 	image_load_addr = 0x2100000;
 	for (*mode = -1; *mode <= 1; (*mode)++) {
 		net_boot_file_size = 1234;
 		ut_asserteq(*mode < 0 ? -EINVAL : *mode, net_loop(TFTPGET));
 		ut_asserteq(*mode > 0 ? 1 : 0, net_boot_file_size);
+		ut_asserteq_str("yes", env_get("autostart"));
 		if (*mode >= 0)
 			ut_asserteq_str("2100000", env_get("fileaddr"));
 	}
diff --git a/test/dm/lwip_tftp.c b/test/dm/lwip_tftp.c
index 3c2562f99a1..7d84120ab4c 100644
--- a/test/dm/lwip_tftp.c
+++ b/test/dm/lwip_tftp.c
@@ -33,6 +33,9 @@ struct tftp_protocol_test {
 	bool initialized;
 	bool fail_data_alloc;
 	bool window_requested;
+	bool server_empty;
+	bool server_followup;
+	bool server_failure;
 	char timeout[4];
 };
 
@@ -724,7 +727,10 @@ static int tftp_test_windows(struct unit_test_state *uts,
 static void tftp_test_server_input(void *arg)
 {
 	static const char wrq[] = "\000\002file\000octet";
+	static const char other[] = "\000\002other\000octet";
 	static const u8 data[] = { 0, 3, 0, 1, 'a', 'b', 'c' };
+	static const u8 extra[] = { 0, 3, 0, 1, 'X', 'Y', 'Z' };
+	static const char error[] = "\000\005\000\001missing";
 	struct tftp_protocol_test *test = arg;
 
 	if (!test->server_phase++) {
@@ -733,35 +739,95 @@ static void tftp_test_server_input(void *arg)
 		/* Lose DATA 1 long enough for the server to retransmit ACK 0. */
 		timer_test_add_offset(5001);
 		sys_timeout(1, tftp_test_server_input, test);
+	} else if (test->server_failure) {
+		test->error = tftp_test_input(test, error, sizeof(error), 0);
 	} else {
-		test->error = tftp_test_input(test, data, sizeof(data), 0);
+		test->error = tftp_test_input(test, data,
+					      test->server_empty ? 4 : sizeof(data), 0);
+	}
+	if (test->server_phase == 2 && test->server_followup && !test->error) {
+		/* More packets can arrive before the command leaves its RX loop. */
+		test->error = tftp_test_input(test, other, sizeof(other), 0);
+		if (!test->error)
+			test->error = tftp_test_input(test, extra, sizeof(extra), 0);
 	}
 }
 
 static int tftp_test_server_command(struct unit_test_state *uts,
 				    struct tftp_protocol_test *test)
 {
-	int ret;
+	int i, ret;
 
 	if (test->initialized)
 		tftp_cleanup();
-	memset(test, 0, sizeof(*test));
-	ipaddr_aton("1.1.2.2", &test->server);
-	ut_assertok(env_set("autostart", "yes"));
-	sys_timeout(1, tftp_test_server_input, test);
-	ret = run_command("tftpsrv 2000000", 0);
-	sys_untimeout(tftp_test_server_input, test);
-	ut_assertok(ret);
-	ut_assertok(test->error);
-	ut_asserteq(2, test->server_phase);
-	ut_asserteq(3, test->sent);
-	ut_asserteq(4, test->opcode);
-	ut_asserteq(1, test->block);
-	ut_asserteq(0x2000000, image_load_addr);
-	ut_asserteq_str("3", env_get("filesize"));
-	ut_asserteq_str("2000000", env_get("fileaddr"));
-	ut_asserteq_str("yes", env_get("autostart"));
-	ut_asserteq_mem("abc", map_sysmem(0x2000000, 3), 3);
+	for (i = 0; i < 4; i++) {
+		memset(test, 0, sizeof(*test));
+		test->server_empty = i == 2;
+		ipaddr_aton("1.1.2.2", &test->server);
+		ut_assertok(env_set("autostart", i ? "yes" : "no"));
+		if (i == 3)
+			ut_assertok(env_set(".flags", "filesize:xr"));
+		sys_timeout(1, tftp_test_server_input, test);
+		ret = run_command("tftpsrv 2000000", 0);
+		sys_untimeout(tftp_test_server_input, test);
+		ut_assertok(env_set(".flags", NULL));
+		/*
+		 * Non-bootable data must fail autostart, but an empty file must
+		 * not boot stale RAM. Metadata errors are transfer failures.
+		 */
+		if (i == 3 || (i == 1 && IS_ENABLED(CONFIG_CMD_BOOTM)))
+			ut_assert(ret != CMD_RET_SUCCESS);
+		else
+			ut_assertok(ret);
+		ut_assertok(test->error);
+		ut_asserteq(2, test->server_phase);
+		ut_asserteq(3, test->sent);
+		ut_asserteq(4, test->opcode);
+		ut_asserteq(1, test->block);
+		ut_asserteq(i >= 2 ? 0 : 3, net_boot_file_size);
+		ut_asserteq(0x2000000, image_load_addr);
+		ut_asserteq_str("2000000", env_get("fileaddr"));
+		ut_asserteq_str(i ? "yes" : "no", env_get("autostart"));
+		ut_asserteq_mem("abc", map_sysmem(0x2000000, 3), 3);
+	}
+	return 0;
+}
+
+static int tftp_test_server_completion(struct unit_test_state *uts,
+				       struct tftp_protocol_test *test)
+{
+	u8 expected[6];
+	void *buf = map_sysmem(0x2000000, sizeof(expected));
+	int i, ret;
+
+	ut_assertok(env_set("autostart", "no"));
+	for (i = 0; i < 3; i++) {
+		memset(test, 0, sizeof(*test));
+		test->server_followup = true;
+		test->server_empty = i == 1;
+		test->server_failure = i == 2;
+		ipaddr_aton("1.1.2.2", &test->server);
+		memset(buf, 0xa5, sizeof(expected));
+		memset(expected, 0xa5, sizeof(expected));
+		if (!i)
+			memcpy(expected, "abc", 3);
+		ut_assertok(env_set("fileaddr", "1234"));
+		ut_assertok(env_set("filesize", "5678"));
+		sys_timeout(1, tftp_test_server_input, test);
+		ret = run_command("tftpsrv 2000000", 0);
+		sys_untimeout(tftp_test_server_input, test);
+		ut_asserteq(i == 2 ? CMD_RET_FAILURE : CMD_RET_SUCCESS, ret);
+		ut_assertok(test->error);
+		ut_asserteq(2, test->server_phase);
+		ut_asserteq(i == 2 ? 4 : 5, test->sent);
+		ut_asserteq(5, test->opcode);
+		ut_asserteq(2, test->block);
+		ut_asserteq(i ? 0 : 3, net_boot_file_size);
+		ut_asserteq_str(i == 2 ? "1234" : "2000000", env_get("fileaddr"));
+		ut_asserteq_str(i == 2 ? "5678" : i ? "0" : "3", env_get("filesize"));
+		ut_asserteq_mem(expected, buf, sizeof(expected));
+	}
+	unmap_sysmem(buf);
 	return 0;
 }
 #endif
@@ -769,7 +835,7 @@ static int tftp_test_server_command(struct unit_test_state *uts,
 static int dm_test_lwip_tftp_protocol(struct unit_test_state *uts)
 {
 	static const char * const vars[] = {
-		"ethact", "ipaddr", "netmask", "fileaddr", "filesize", "autostart",
+		"ethact", "ipaddr", "netmask", "fileaddr", "filesize", "autostart", ".flags",
 	};
 	struct tftp_protocol_test test = {};
 	struct net_lwip_ctx net = {};
@@ -817,6 +883,8 @@ static int dm_test_lwip_tftp_protocol(struct unit_test_state *uts)
 #if IS_ENABLED(CONFIG_CMD_TFTPSRV)
 	if (!ret)
 		ret = tftp_test_server_command(uts, &test);
+	if (!ret)
+		ret = tftp_test_server_completion(uts, &test);
 #endif
 	if (test.initialized)
 		tftp_cleanup();
@@ -824,6 +892,7 @@ static int dm_test_lwip_tftp_protocol(struct unit_test_state *uts)
 	tftp_test_active = NULL;
 	net_lwip_stop(&net);
 restore_env:
+	env_set(".flags", NULL);
 	image_load_addr = load_addr;
 	net_boot_file_size = size;
 	for (i = 0; i < ARRAY_SIZE(vars); i++)
diff --git a/test/dm/tftp.c b/test/dm/tftp.c
index eb178573312..b70aa6f4722 100644
--- a/test/dm/tftp.c
+++ b/test/dm/tftp.c
@@ -15,6 +15,10 @@
 #include <asm/unaligned.h>
 #include <dm/test.h>
 #include <test/ut.h>
+#if IS_ENABLED(CONFIG_NET_LWIP)
+#include <lwip/timeouts.h>
+#include <lwip/udp.h>
+#endif
 
 static const char tftp_test_data[] = "update data, not a bootable image";
 
@@ -29,6 +33,7 @@ enum tftp_test_probe {
 
 struct tftp_test_context {
 	bool fail;
+	bool empty;
 	bool autostart;
 	unsigned int requests;
 	unsigned int arp_requests;
@@ -41,8 +46,47 @@ struct tftp_test_context {
 	ulong ack_start;
 	ulong ack_delay;
 	unsigned int advertised_timeout;
+	char filename[64];
+	u16 blocksize;
+	u16 windowsize;
+	u16 port;
 };
 
+static ulong tftp_test_option(const char *packet, size_t len, const char *option)
+{
+	const char *end = packet + len;
+	const char *name = packet + 2;
+	size_t size;
+	int i;
+
+	/* Skip the request's filename and mode before walking option pairs. */
+	for (i = 0; i < 2; i++) {
+		if (name >= end)
+			return 0;
+		size = strnlen(name, end - name);
+		if (size == end - name)
+			return 0;
+		name += size + 1;
+	}
+	while (name < end) {
+		const char *value;
+
+		size = strnlen(name, end - name);
+		if (size == end - name)
+			break;
+		value = name + size + 1;
+		if (value >= end)
+			break;
+		size = strnlen(value, end - value);
+		if (size == end - value)
+			break;
+		if (!strcmp(name, option))
+			return simple_strtoul(value, NULL, 10);
+		name = value + size + 1;
+	}
+	return 0;
+}
+
 /* Answer an RRQ with one short DATA block or a file-not-found error. */
 static int tftp_test_tx_handler(struct udevice *dev, void *packet,
 				unsigned int len)
@@ -52,9 +96,9 @@ static int tftp_test_tx_handler(struct udevice *dev, void *packet,
 	struct ethernet_hdr *eth = packet, *reply_eth;
 	struct ip_udp_hdr *ip, *reply_ip;
 	const char *data = ctx->fail ? "not found" : tftp_test_data;
-	unsigned int data_len = strlen(data) + 1;
+	unsigned int data_len = ctx->empty ? 0 : strlen(data) + 1;
 	unsigned int reply_len, header_len = 4;
-	u16 opcode, reply_opcode = ctx->fail ? 5 : 3, block = 1;
+	u16 opcode, reply_opcode = 3, block = 1;
 	bool partial = false;
 	u8 *payload;
 
@@ -98,16 +142,16 @@ static int tftp_test_tx_handler(struct udevice *dev, void *packet,
 			return 0;
 		ctx->ack_delay = get_timer(ctx->ack_start);
 		block = ctx->probe == TFTP_PROBE_DATA ? 2 : 1;
-	} else if (opcode == 1 && ntohs(ip->udp_dst) == 69) {
-		unsigned int i, request_len = len - ETHER_HDR_SIZE - IP_UDP_HDR_SIZE;
+	} else if (opcode == 1 || opcode == 2) {
+		size_t request_len = len - ETHER_HDR_SIZE - IP_UDP_HDR_SIZE;
 
 		if (!ctx->requests++)
 			ctx->request_start = get_timer(0);
-		payload = (void *)(ip + 1);
-		for (i = 2; i + 10 <= request_len; i++) {
-			if (!memcmp(payload + i, "timeout\0", 8))
-				ctx->advertised_timeout = dectoul((char *)payload + i + 8, NULL);
-		}
+		strlcpy(ctx->filename, (char *)(ip + 1) + 2, sizeof(ctx->filename));
+		ctx->blocksize = tftp_test_option((char *)(ip + 1), request_len, "blksize");
+		ctx->windowsize = tftp_test_option((char *)(ip + 1), request_len, "windowsize");
+		ctx->port = ntohs(ip->udp_dst);
+		ctx->advertised_timeout = tftp_test_option((char *)(ip + 1), request_len, "timeout");
 		if (ctx->probe == TFTP_PROBE_SILENT)
 			return 0;
 		if (ctx->probe == TFTP_PROBE_DATA) {
@@ -123,13 +167,23 @@ static int tftp_test_tx_handler(struct udevice *dev, void *packet,
 				"timeout\0" "1" : "timeout\0" "5";
 			data_len = 10;
 		}
+		if (opcode == 2) {
+			reply_opcode = 4;
+			block = 0;
+			data_len = 0;
+		}
+	} else if (ntohs(ip->udp_dst) == 1234 && opcode == 3 &&
+		   len >= ETHER_HDR_SIZE + IP_UDP_HDR_SIZE + 4) {
+		reply_opcode = 4;
+		block = get_unaligned_be16((u8 *)(ip + 1) + 2);
+		data_len = 0;
 	} else {
 		return 0;
 	}
+	reply_len = ETHER_HDR_SIZE + IP_UDP_HDR_SIZE + header_len + data_len;
 	if (priv->recv_packets >= PKTBUFSRX)
 		return -ENOSPC;
 
-	reply_len = ETHER_HDR_SIZE + IP_UDP_HDR_SIZE + header_len + data_len;
 	ctx->autostart |= env_get_autostart();
 	reply_eth = (void *)priv->recv_packet_buffer[priv->recv_packets];
 	memcpy(reply_eth->et_dest, eth->et_src, ARP_HLEN);
@@ -149,7 +203,7 @@ static int tftp_test_tx_handler(struct udevice *dev, void *packet,
 	reply_ip->udp_len = htons(UDP_HDR_SIZE + header_len + data_len);
 	reply_ip->ip_sum = compute_ip_checksum(reply_ip, IP_HDR_SIZE);
 	payload = (void *)(reply_ip + 1);
-	put_unaligned_be16(reply_opcode, payload);
+	put_unaligned_be16(ctx->fail ? 5 : reply_opcode, payload);
 	if (header_len == 4)
 		put_unaligned_be16(block, payload + 2);
 	if (partial)
@@ -257,11 +311,140 @@ static int tftp_test_probe_timeout(struct unit_test_state *uts,
 	return 0;
 }
 
+static int tftp_test_filenames(struct unit_test_state *uts,
+			       struct tftp_test_context *ctx)
+{
+	static const char * const files[] = {
+		"dir:file", "dir:one:two:file", "1.1.2.2:path:file",
+	};
+	static const char * const expected[] = {
+		"dir:file", "dir:one:two:file", "path:file",
+	};
+	char command[100];
+	int i;
+
+	ut_assertok(env_set("autostart", "no"));
+	for (i = 0; i < ARRAY_SIZE(files); i++) {
+		memset(ctx, 0, sizeof(*ctx));
+		snprintf(command, sizeof(command), "tftpboot 2000000 %s", files[i]);
+		ut_assertok(run_command(command, 0));
+		ut_asserteq(1, ctx->requests);
+		ut_asserteq_str(expected[i], ctx->filename);
+		ut_assertok(env_set("bootfile", files[i]));
+		ut_assertok(run_command("tftpboot 2000000", 0));
+		ut_asserteq_str(expected[i], ctx->filename);
+	}
+	if (IS_ENABLED(CONFIG_NET_LWIP)) {
+		/* Keep the lwIP numeric-port extension, including filename colons. */
+		ut_assertok(run_command("tftpboot 2000000 1.1.2.2:1069:path:to:file", 0));
+		ut_asserteq(1069, ctx->port);
+		ut_asserteq_str("path:to:file", ctx->filename);
+		ut_assertok(run_command("tftpboot 2000000 :1069:path:to:file", 0));
+		ut_asserteq_str("path:to:file", ctx->filename);
+		ut_assertok(run_command("tftpboot 2000000 1.1.2.2::path:file", 0));
+		ut_asserteq(69, ctx->port);
+		ut_asserteq_str("path:file", ctx->filename);
+		memset(ctx, 0, sizeof(*ctx));
+		ut_asserteq(CMD_RET_FAILURE,
+			    run_command("tftpboot 2000000 1.1.2.2:65536:file", 0));
+		ut_asserteq(0, ctx->requests);
+	}
+	return 0;
+}
+
+#if IS_ENABLED(CONFIG_NET_LWIP)
+static int tftp_test_options(struct unit_test_state *uts,
+			     struct tftp_test_context *ctx)
+{
+	static const struct {
+		const char *value;
+		bool valid;
+	} sizes[] = {
+		{ NULL, true },
+		{ "512", true },
+		{ "4096", true },
+		{ "65464", true },
+		{ "1", false },
+		{ "bad", false },
+	};
+	ulong rx_max = IP_REASSEMBLY ?
+		min_t(ulong, 65464, IP_REASS_MAX_PBUFS * IP_FRAG_MTU_USABLE - 12) : 1468;
+	bool vars = IS_ENABLED(CONFIG_NET_TFTP_VARS);
+	ulong requested, expected;
+	int i, put, ret;
+
+	ut_assertok(env_set("autostart", "no"));
+	ut_assertok(env_set("tftpwindowsize", "4"));
+	for (put = 0; put <= IS_ENABLED(CONFIG_CMD_TFTPPUT); put++) {
+		for (i = 0; i < ARRAY_SIZE(sizes); i++) {
+			memset(ctx, 0, sizeof(*ctx));
+			ut_assertok(env_set("tftpblocksize", sizes[i].value));
+			ret = run_command(put ? "tftpput 2000000 20 file" :
+					  "tftpboot 2000000 file", 0);
+			if (vars && !sizes[i].valid) {
+				ut_asserteq(CMD_RET_FAILURE, ret);
+				ut_asserteq(0, ctx->requests);
+				continue;
+			}
+			ut_assertok(ret);
+			requested = vars && sizes[i].value ?
+				simple_strtoul(sizes[i].value, NULL, 10) : CONFIG_TFTP_BLOCKSIZE;
+			expected = min(requested, put ? 1468UL : rx_max);
+			/* The default block size does not need an on-wire option. */
+			ut_asserteq(expected == 512 ? 0 : expected, ctx->blocksize);
+			expected = vars ? 4 : CONFIG_TFTP_WINDOWSIZE;
+			ut_asserteq(put || expected == 1 ? 0 : expected, ctx->windowsize);
+		}
+	}
+	ut_assertok(env_set("tftpblocksize", NULL));
+	ut_assertok(env_set("tftpwindowsize", "bad"));
+	memset(ctx, 0, sizeof(*ctx));
+	ret = run_command("tftpboot 2000000 file", 0);
+	ut_asserteq(vars ? CMD_RET_FAILURE : CMD_RET_SUCCESS, ret);
+	ut_asserteq(vars ? 0 : 1, ctx->requests);
+	ut_assertok(env_set("tftpwindowsize", NULL));
+	return 0;
+}
+#endif
+
+static int tftp_test_protected_autostart(struct unit_test_state *uts,
+					 struct tftp_test_context *ctx)
+{
+	char * const argv[] = { "tftpboot", "2000000", "update.bin" };
+	int enabled, helper, ret;
+
+	for (enabled = 0; enabled < 2; enabled++) {
+		ut_assertok(env_set("autostart", enabled ? "yes" : "no"));
+		ut_assertok(env_set(".flags", "autostart:br"));
+		for (helper = 0; helper < 3; helper++) {
+			memset(ctx, 0, sizeof(*ctx));
+			switch (helper) {
+			case 0:
+				ret = tftpb_run(TFTP_TEST_ADDR, "update.bin");
+				break;
+			case 1:
+				ret = tftpb_run_timeout(TFTP_TEST_ADDR, "update.bin", 100, 0);
+				break;
+			default:
+				ret = tftpb_run_argv(3, argv);
+			}
+			/* Do not override protection when suppression is required. */
+			ut_asserteq(enabled, !!ret);
+			ut_asserteq(!enabled, ctx->requests);
+			ut_assert(!ctx->autostart);
+			ut_asserteq_str(enabled ? "yes" : "no", env_get("autostart"));
+		}
+		ut_assertok(env_set(".flags", NULL));
+	}
+	return 0;
+}
+
 static int tftp_test_download(struct unit_test_state *uts,
 			      struct tftp_test_context *ctx)
 {
 	static const char * const autostart[] = { "yes", NULL, "no", "yes-please" };
 	const char *timeout, *retries;
+	char * const argv[] = { "tftpboot", "2000000", "update.bin" };
 	void *buffer = map_sysmem(TFTP_TEST_ADDR, sizeof(tftp_test_data));
 	int i, fail, ret;
 
@@ -277,22 +460,74 @@ static int tftp_test_download(struct unit_test_state *uts,
 	ut_assertok(tftp_test_probe_arp(uts, ctx));
 	ut_assertok(tftp_test_probe_timeout(uts, ctx));
 
+	ut_assertok(tftp_test_protected_autostart(uts, ctx));
+
+#if IS_ENABLED(CONFIG_NET_LWIP)
+	ut_assertok(tftp_test_options(uts, ctx));
+#endif
+	ut_assertok(tftp_test_filenames(uts, ctx));
+
+	/* A previous DHCP/download must not override the next command's env. */
+	ut_assertok(env_set("autostart", "no"));
+	ut_assertok(env_set("loadaddr", "2000000"));
+	for (i = 0; i < 3; i++) {
+		strcpy(net_boot_file_name, "stale.bin");
+		ut_assertok(env_set("bootfile", i == 2 ? NULL : "fresh.bin"));
+		memset(ctx, 0, sizeof(*ctx));
+		ut_assertok(run_command(i == 1 ? "tftpboot 2000000" : "tftpboot", 0));
+		ut_asserteq_str(i == 2 ? "01010203.img" : "fresh.bin", ctx->filename);
+		ut_asserteq(1, ctx->requests);
+	}
+	strcpy(net_boot_file_name, "stale.bin");
+	ut_assertok(env_set("bootfile", "helper.bin"));
+	ut_assertok(tftpb_run(TFTP_TEST_ADDR, NULL));
+	ut_asserteq_str("helper.bin", ctx->filename);
+
+#if IS_ENABLED(CONFIG_NET_LWIP) && IS_ENABLED(CONFIG_NET_TFTP_VARS)
+	/* Reject delays outside lwIP's wrap-safe timer range before an RRQ. */
+	ut_assertok(env_set("autostart", "no"));
+	for (i = 0; i < 3; i++) {
+		static const char * const delays[] = {
+			"1073741823", "1073741824", "4294967295",
+		};
+
+		memset(ctx, 0, sizeof(*ctx));
+		net_boot_file_size = 1234;
+		ut_assertok(env_set("tftptimeout", delays[i]));
+		ret = do_tftpb(NULL, 0, 3, argv);
+		ut_asserteq(i ? CMD_RET_FAILURE : CMD_RET_SUCCESS, ret);
+		ut_asserteq(i ? 0 : 1, ctx->requests);
+		ut_asserteq(i ? 0 : sizeof(tftp_test_data), net_boot_file_size);
+		ut_asserteq(-ENODEV, net_lwip_poll());
+	}
+	ut_assertok(env_set("tftptimeout", NULL));
+#endif
+
 	for (i = 0; i < ARRAY_SIZE(autostart); i++) {
 		timeout = i & 1 ? NULL : "7000";
 		retries = i & 1 ? NULL : "09";
-		for (fail = 0; fail < 2; fail++) {
+		for (fail = 0; fail < 6; fail++) {
 			ut_assertok(env_set("autostart", autostart[i]));
 			ut_assertok(env_set("tftptimeout", timeout));
 			ut_assertok(env_set("tftptimeoutcountmax", retries));
 			memset(buffer, 0, sizeof(tftp_test_data));
 			memset(ctx, 0, sizeof(*ctx));
-			ctx->fail = fail;
+			ctx->fail = fail & 1;
 
-			ret = tftpb_run_timeout(TFTP_TEST_ADDR, "update.bin", 100, 0);
-			ut_asserteq(fail ? -ENOENT : 0, ret);
+			switch (fail / 2) {
+			case 0:
+				ret = tftpb_run_timeout(TFTP_TEST_ADDR, "update.bin", 100, 0);
+				break;
+			case 1:
+				ret = tftpb_run(TFTP_TEST_ADDR, "update.bin");
+				break;
+			default:
+				ret = tftpb_run_argv(3, argv) ? -ENOENT : 0;
+			}
+			ut_asserteq(ctx->fail ? -ENOENT : 0, ret);
 			ut_asserteq(1, ctx->requests);
 			ut_assert(!ctx->autostart);
-			if (!fail) {
+			if (!ctx->fail) {
 				ut_asserteq(sizeof(tftp_test_data), net_boot_file_size);
 				ut_asserteq_mem(tftp_test_data, buffer,
 						sizeof(tftp_test_data));
@@ -310,6 +545,40 @@ static int tftp_test_download(struct unit_test_state *uts,
 			}
 		}
 	}
+	if (IS_ENABLED(CONFIG_CMD_BOOTM)) {
+		/* An empty successful download must not boot stale RAM contents. */
+		memset(ctx, 0, sizeof(*ctx));
+		ctx->empty = true;
+		ut_assertok(env_set("autostart", "yes"));
+		ut_assertok(do_tftpb(NULL, 0, 3, argv));
+		ut_asserteq(1, ctx->requests);
+		ut_asserteq(0, net_boot_file_size);
+
+		/*
+		 * The same bytes are not bootable. A command must attempt boot
+		 * and return its failure, unlike the download-only helpers above.
+		 */
+		memset(ctx, 0, sizeof(*ctx));
+		ut_assertok(env_set("autostart", "yes"));
+		ut_assert(do_tftpb(NULL, 0, 3, argv) != CMD_RET_SUCCESS);
+		ut_asserteq(1, ctx->requests);
+		ut_assert(ctx->autostart);
+		ut_asserteq(sizeof(tftp_test_data), net_boot_file_size);
+		ut_asserteq_str("yes", env_get("autostart"));
+#if IS_ENABLED(CONFIG_NET_LWIP)
+		ut_asserteq(-ENODEV, net_lwip_poll());
+#endif
+	}
+#if IS_ENABLED(CONFIG_NET_LWIP) && IS_ENABLED(CONFIG_CMD_TFTPPUT)
+	/* Uploading non-bootable bytes is not a request to boot their source. */
+	memset(ctx, 0, sizeof(*ctx));
+	ut_assertok(env_set("autostart", "yes"));
+	ut_assertok(run_command("tftpput 2000000 20 update.bin", 0));
+	ut_asserteq(1, ctx->requests);
+	ut_assert(ctx->autostart);
+	ut_asserteq_str("yes", env_get("autostart"));
+	ut_asserteq(-ENODEV, net_lwip_poll());
+#endif
 	unmap_sysmem(buffer);
 
 	return 0;
@@ -321,6 +590,8 @@ static int dm_test_tftp_download_only(struct unit_test_state *uts)
 		"autostart", "tftptimeout", "tftptimeoutcountmax", "ethact",
 		"ipaddr", "serverip", "netmask", "gatewayip", "netretry", "tftpsrcp",
 		"tftpdstp", "tftpserverip", "fileaddr", "filesize",
+		"bootaddr", "loadaddr", "bootfile", "ethrotate", ".flags",
+		"tftpblocksize", "tftpwindowsize",
 	};
 	char saved_bootfile[sizeof(net_boot_file_name)];
 	ulong saved_load_addr = image_load_addr;

-- 
2.53.0

