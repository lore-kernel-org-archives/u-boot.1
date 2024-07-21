Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA088C3DA61
	for <u-boot@archiver.kernel.org>; Sun, 21 Jul 2024 10:10:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ABBC287F51;
	Sun, 21 Jul 2024 12:09:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="G1AJWCwH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 086358657F; Sun, 21 Jul 2024 12:09:51 +0200 (CEST)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B9AB87702
 for <u-boot@lists.denx.de>; Sun, 21 Jul 2024 12:09:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-369cb9f086aso252345f8f.0
 for <u-boot@lists.denx.de>; Sun, 21 Jul 2024 03:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721556588; x=1722161388; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l2wNqzT5MB3WU3QIYPvENWUo2cQMUiJ/5H2QOdCb+t0=;
 b=G1AJWCwHgZPtogWSkb6jnRmuPtsNJDBl7mH7Q0K0GGtoIF+9wEv4fYYy4i8K9Wk4uU
 k0OuiLnnZWG9gffCcdXAh8Ok7zT6FsErtrkZUIkAmb/ca/ofGXU1gUne0Lgy2au07X1y
 8vKrHbrHrP7WnYr9vqsz1CR+F6x5aNiBW2Vfk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721556588; x=1722161388;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l2wNqzT5MB3WU3QIYPvENWUo2cQMUiJ/5H2QOdCb+t0=;
 b=LTaoYwZlTnaA0cJ7DIYLeZ4XsCu7BL/M8dI2reZhUv5uLxu6gYnOHzI6W8oW3HUKoc
 TuKhaVvV+WwX7uKMuk3/pykbroiJgbFMVXmKKF2P4R64hKZs08JRrEDZYX8qBCjyi3DD
 hVmsu6QxEcbJ+l7XPBoZanVu+TSWCrvC1gF1UVGaLIoHEcwGpthkNR7m8XoJnOkAM9qo
 9nzQBoQUHs6+3EyjSbEUwHJN2RmGd3670wkKRjz3vXkmCy81oTc2naBBXYaG8YqDHL7U
 8ww2LkbcO1ZgnI4gO0PJAW4gJgUKgpHK0FZwsp1NWnUo1/NZhOBlvobJcmBvKht3wq0j
 e9iA==
X-Gm-Message-State: AOJu0Yw/1k0nogImnjcdxha8Wxbap721zFR4lde7MM+WGJ3UgmG+amkG
 r4WjOC3+sQhfkH0NeM/+5HFU653lvOKF0/capJeW2H7c86suOMo5DdcNZnm58Ml6cgUCZ3TFqzs
 =
X-Google-Smtp-Source: AGHT+IEwI1Defv4QvUe4tx3YmkhbinWKwlZ351VvkrwlT+4KoDNGJEUV7rNsO3LzaPpFzBNQJGRbPA==
X-Received: by 2002:a05:6000:18aa:b0:367:4dbb:ed51 with SMTP id
 ffacd0b85a97d-369bad97dfemr2186601f8f.0.1721556588128; 
 Sun, 21 Jul 2024 03:09:48 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d69013fasm85096265e9.12.2024.07.21.03.09.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Jul 2024 03:09:47 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Sean Anderson <seanga2@gmail.com>,
 Lean Sheng Tan <sheng.tan@9elements.com>, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Michal Simek <michal.simek@amd.com>, Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
Subject: [PATCH v3 01/21] sandbox: Use const in os_jump_to_file()
Date: Sun, 21 Jul 2024 11:09:19 +0100
Message-Id: <20240721100940.3202027-2-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240721100940.3202027-1-sjg@chromium.org>
References: <20240721100940.3202027-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The argument array is not changed by the callee, so mark it const.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
---

(no changes since v1)

 arch/sandbox/cpu/os.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/sandbox/cpu/os.c b/arch/sandbox/cpu/os.c
index 46ff305b536..a04eb5aa18c 100644
--- a/arch/sandbox/cpu/os.c
+++ b/arch/sandbox/cpu/os.c
@@ -808,7 +808,7 @@ static int make_exec(char *fname, const void *data, int size)
  * @count: Number of arguments in @add_args
  * Return: 0 if OK, -ENOMEM if out of memory
  */
-static int add_args(char ***argvp, char *add_args[], int count)
+static int add_args(char ***argvp, const char *add_args[], int count)
 {
 	char **argv, **ap;
 	int argc;
@@ -859,7 +859,7 @@ static int os_jump_to_file(const char *fname, bool delete_it)
 	struct sandbox_state *state = state_get_current();
 	char mem_fname[30];
 	int fd, err;
-	char *extra_args[5];
+	const char *extra_args[5];
 	char **argv = state->argv;
 	int argc;
 #ifdef DEBUG
-- 
2.34.1

