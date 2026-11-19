Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76CCF606A320
	for <u-boot@archiver.kernel.org>; Thu, 19 Nov 2026 15:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=AsawqJAd;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B1OXSwST
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 55D404055A;
	Thu, 19 Nov 2026 15:25:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id l7YR14e9dt2m; Thu, 19 Nov 2026 15:25:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B65C5405AE
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795101912;
	b=ITbtLkc4xD5xqPK3TQUgcQOrFpEm5mNJVe9QE417/QxJ8I9eHe87rnywWm5+Z68maRvt
	 sklzoas6aZJCRbKbWrH9tCvF2+7WQJO/DqLJ9dqY8g+0LwmsSg1TOvCAM1RPVdd8cexP6
	 eGqCXz8p45Dw6NBRJe6LM8M2Jofv8vWIwgS8332r8CnD6aw20nwUzudMaP3B0/l3TFqas
	 4VbV8lQ2R4D7TTpAyJeYMw7A23U4zZzGC17gXjooh5fm0jSDUkqDKUZ/gFIWrLP9rACkR
	 V6vJ858YHrxa8CdHGGgFo8kJ3n3eSrvZK+JZ/yr7PYS6GLbNsCjG4+khwKqBN/xrbkw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795101912;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=uPjaKsPNw1JmGHNb2UXVL6nuOpxZS5L6p4KF6eL0Q3o=;
	b=PLQ3bN4POj8sdZekvX/3jObb/TMZKXvWN7tD9qj16K9/bvg42n9RwUU10RApyVaIFz8T
	 E1R1V4Ggmv8Z7OQtmqATh00u9jUjqOSV0v7BCAeBpnoqQRvFcx3drbrKVSGNSdRclTsTE
	 +hSJoJFGI9bB/EHT5rov0lJR96U2DfyHpuzKsloUPsuxAoPL8EUtPuO1Bh9XKTVM95JZE
	 +Qypl9U5wcwaaoXHFIlJLFDrDxeofhCA2aftywDmQ8us0fEIreq4Tqs+oSgVbllMeQFBt
	 NKfnnR+yqvac++HZ0D5xmm79sUfwg6XX78Su4Fez6Y5z/+3UVrVgpF1oqSbtLW5B4Jw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795101912;
	bh=uPjaKsPNw1JmGHNb2UXVL6nuOpxZS5L6p4KF6eL0Q3o=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AsawqJAdw6uyiai69yo2CSjC0hkNBgUJdP8NPpsE7KDxlOmlyiO3jqFWd1Asx4TCC
	 ftqRY3TWcILbsduteaH7DjIuR5La0wJdjcr6NT6b0g2JCvuVrZZ+1r3OaTTjng1YZX
	 hykkOfQm1sBu6DWkpOjfMYKzxxllJn2+WhYPwhWBo2c7Ym/eR3WPtXBLHjW/B/osOV
	 dyC5eG+sLPQDgT2R6ngrDXuv1yp0jEKqGeaxmm77ijov2C4GTtiQgoxkEWoExdVoMB
	 5st5BeyZLHroAIAZVVSnhIe7FoYHYvH6nqbFKvxQ1edtUVEaa4efvoLl8Wk/NlueYo
	 BHuiKw7BGKehw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B65C5405AE;
	Thu, 19 Nov 2026 15:25:12 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 977882FB
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 15:25:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7D9E360ADF
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 15:25:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3tqsaZdc7NJA for <u-boot@lists.u-boot-project.org>;
 Thu, 19 Nov 2026 15:25:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org DB43360686
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=mkorpershoek@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=B1OXSwST
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DB43360686
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 15:25:03 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 84BA1626E1;
 Thu, 19 Nov 2026 15:25:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD3ED1F000C4;
 Thu, 19 Nov 2026 15:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795101902;
 bh=uPjaKsPNw1JmGHNb2UXVL6nuOpxZS5L6p4KF6eL0Q3o=;
 h=Subject:From:To:Cc:In-Reply-To:References:Date;
 b=B1OXSwSTcen2WM7jVj6sbWsXZyslgWqxXQTSetym9bjfMxbK33cRhqxq+0t0VEufT
 yC0FaKowX9dYiR+PbSmfV+BkpNxI5SCHhihrK9swzZTfXdlirviRyFmXFycLD0nMtj
 pdPY5oW9T/osFPmSrDV/FZ/POKh7QEF+qIe/ZxT/KF5WQaUBzMwHbE2CVY3Euq2btd
 JJu+IBGIbl7f4csM1K6cQst0+KXPmrKGzcM+UjaX4sKVstZ4pJWfNuprfnQ6TKQn1G
 2Y5QgnmVqjfoi3Uz9JD0rEmGMROWzToGX65FnXgKq7UjXxzj2RxMLxvje8uN0JjmhM
 11LLU9bGn/rnw==
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 04/14] usb: gadget: firehose: add the erase command
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Cc: u-boot@lists.u-boot-project.org, Sumit Garg <sumit.garg@kernel.org>, 
 u-boot-qcom@groups.io, Tom Rini <trini@konsulko.com>, 
 Lukasz Majewski <lukma@nabladev.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Marek Vasut <marek.vasut+usb@mailbox.org>, Johan Jonker <jbx6244@gmail.com>, 
 Vitor Sato Eschholz <vsatoes@baylibre.com>, 
 Carlo Caione <ccaione@baylibre.com>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, Simon Glass <sjg@chromium.org>, 
 Mehmet Fide <mehmet.fide@screeningeagle.com>, 
 Vincent Jardin <vjardin@free.fr>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Michael Srba <Michael.Srba@seznam.cz>, 
 Biswapriyo Nath <nathbappai@gmail.com>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Daniel Golle <daniel@makrotopia.org>, 
 Rasmus Villemoes <rv@rasmusvillemoes.dk>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>
In-Reply-To: <20261106-firehose-v1-v1-4-e7591c12fc65@oss.qualcomm.com>
References: <20261106-firehose-v1-v1-0-e7591c12fc65@oss.qualcomm.com>
 <20261106-firehose-v1-v1-4-e7591c12fc65@oss.qualcomm.com>
Date: Thu, 19 Nov 2026 16:24:46 +0100
Message-Id: <179510188629.516692.1808337062389566.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=263;
 i=mkorpershoek@kernel.org; h=from:subject:message-id;
 bh=rsmlHB/W/B8eWqdYMbsjHf4YzVqxpSdO1eD0YK2YF70=;
 b=owEBbQGS/pANAwAKARkNHbRmThk1AcsmYgBq/xTFr+01QK9fqk3p4v53glyHskc5mjAMM2y5O
 lUzXlQT0J6JATMEAAEKAB0WIQQu6UKnth9qvlMTrQAZDR20Zk4ZNQUCav8UxQAKCRAZDR20Zk4Z
 NddRCADi9yR4ZyF6Xrdm0AgFeuoNgcQLpzEiGDUM90OfvRsvpfaS+uTurBxCBOtU8YSXwGxsLFS
 Yyh0WM2ZYsjjfIz4l9Ldc/WEe9nPZDjG1hIziTBz9pU63PR6jJzaqJ8ezlYFtawqLnxYbaFTHpM
 2yBBdnYUNc+tdgXQvzTkqePMt1ywt+/Zkh9ZE3as6FNQz5jaEr6zwhgA2c+TQxMz0i9ijiexUjp
 eUwrAZQWKtyjNvfyiX3q6Aap7sWF+Vcd2SlKHfqsN976ghZIokCOiL7G5UfWknahIOF1LP2zHJG
 eq1HhVqrpldzDjK5i9tZs36CN1qdyO7Nk9pM3V9zo3+6BAkP
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
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 06 Nov 2026 10:42:36 +0100, Igor Opaniuk <igor.opaniuk@oss.qualcomm.com> wrote:
> Erase a sector range, or the whole device without one.

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

-- 
Mattijs Korpershoek <mkorpershoek@kernel.org>
