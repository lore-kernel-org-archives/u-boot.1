Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F86DC3ABBE
	for <u-boot@archiver.kernel.org>; Thu,  8 May 2025 21:42:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D71D8297E;
	Thu,  8 May 2025 23:42:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="MeUjwgs6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 995E88269F; Thu,  8 May 2025 23:42:28 +0200 (CEST)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7AA008269F
 for <u-boot@lists.denx.de>; Thu,  8 May 2025 23:42:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-72ecc30903cso840199a34.0
 for <u-boot@lists.denx.de>; Thu, 08 May 2025 14:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1746740545; x=1747345345; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HsWoopB6GHw9RRMcMYrdKhuCRiaTsP8SsHuK306WSOQ=;
 b=MeUjwgs6CQbPsI8AQK+YE7OoYCNZ7/wfptVNhaDQUy0lHF8oqwYy/yInGR193A9SRQ
 i9FKRAf013P0gE9aS+JUpf9SENeDMW26/9vWCrmbEamQx2gIdI8zsnG9ZJPAFS6+TFdh
 ZQ/RbEHLBWmo55/cEaZZ7Grr1aOk+ePnjgUOA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746740545; x=1747345345;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HsWoopB6GHw9RRMcMYrdKhuCRiaTsP8SsHuK306WSOQ=;
 b=p3+xIWhwI6YjSCYnCeT8WRCdqHYLd3Ib0b9Wq2rLQxhppr80UBvlr1IzE7TDk6lDsm
 Q5wl9gTGBbWeRXM9HDX3+pADxXk1dPM2binJOVJm3h0czvXH/GJd0ftglJcmTlAt66uU
 5wHHNo5WxjPstUubHsdSZD8xrxjWH2SSoYC24YLx5mil/LSOda7VmDg+9UbD8vMzrf00
 ZxoDZHzYX1COi4WIYsOxn9wCrYkUW8MW1CPeSf5GlAVavsz9JQ4+K0iU8QDnDwlRxjW1
 +ZtqAzgZ3tfNIT3dn0kP+zVjit0ZxW70V/sgKiWQ1LXUbI5efUVREjhAsv4mYdvMvAuW
 Updw==
X-Gm-Message-State: AOJu0YzVzqO9Ywk6KWpTSQUhGYmhrYOGemwMDwiezajamipuzNXMyocG
 dADtPAKWEZeZ2IGQ9GrZ71Fz9nsrfDVrjrjRAE8N1VFgUIfvuKc0mb5nuYqBlSJFWjlaqGpW+c7
 p
X-Gm-Gg: ASbGncsI401Gpiv7CsrQsZz5NOMSaX4+rVSVdv+CcVA8dLprrs6CP6n4DhPo8b6G3bl
 LXB9KAJaEAiLFxIhSU5wHC3tXybSfQ2tywkGzvEQC7fWKN5xtAzCOmU4YPyI5iy9cZ4M7V6RRoG
 YrNqOBB0gZLaV4V7GH2UOt8dy+W9xYpKvD8AxlIi3OPkQNpsOGjQXTQyQ9HgoGMztv47IHxXPUO
 otanwYO51cBQa3SmfOC/pEYtclLaZqJQALqjTGVoU+R11cn6lL/XgYZ4XXhV1OOW4aopYxz+ZkW
 IkMOQnIb5nCveD03uRdK+YKOyCYpUAjWmYnZQSukbBOJrj+EqeFCpGVTkP54VYjpwrF8+3HpPX5
 TJie7
X-Google-Smtp-Source: AGHT+IEcI2zfmoNwGCtFe/yeau+q6G+sn4FKymWPPP7ILXKw+mfe9CKf+jtWm2m1hmhpXVlMlzCLug==
X-Received: by 2002:a05:6830:650e:b0:72b:8fd3:e2dc with SMTP id
 46e09a7af769-73226aaed96mr1262403a34.21.1746740545158; 
 Thu, 08 May 2025 14:42:25 -0700 (PDT)
Received: from bill-the-cat.. (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-732264d439esm266167a34.30.2025.05.08.14.42.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 May 2025 14:42:24 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH 0/3] doc: Document remaining test_b* tests
Date: Thu,  8 May 2025 15:34:42 -0600
Message-ID: <20250508214222.643020-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250507232500.527782-1-trini@konsulko.com>
References: <20250507232500.527782-1-trini@konsulko.com>
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

Hey all,

This short series is a follow-up to my last series. It could have been
longer, but I think this is a good point to get some feedback on a few
points.

As background, something I wondered about and the answer seems to be No
is, can we automatically take things like:
@pytest.mark.buildconfigspec('cmd_button')
and get some nice output? Since we can't that limits the value,
possibly, of generating some documentation.

First, as this series shows, is there value in documenting tests which
do not require additional configuration? We have some tests with no
comments and some that are fully commented, but at the end of the day
when trying to run these tests, pytest will already say helpful things
like not being supported on a given platform, or not run because
something isn't enabled in the build. Spelling that out in generated
documentation would require duplication of work.

Second, is there value in documenting arguments? Especially ones like
"ubman" that are just required and always present?

Third, should we document internal functions too, or just the tests? I
would be inclined to say no unless they're expected to be re-used. The
test_net functions to bring up the networking are an example that of
reuse that should be documented for example.

-- 
Tom

